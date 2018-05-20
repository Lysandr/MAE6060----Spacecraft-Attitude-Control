% Envelope of momentum or torque for RWAs (or instantaneous torques for CMGs)
%
typ=7;

if ~exist('typ'), typ=1; end
switch typ
case 1
    ttext = 'Boeing Style Array'
    vecs = [ 1  1 -1 -1; sqrt(2)*[-1 -1 -1 -1 ]; 1 -1  1 -1 ]/2;
case 2
	ttext = 'Loral Style Array'
	vecs = diag([sqrt(3/8) sqrt(3/8) 0.5])*[0 sqrt(2) -1 -1;0 0 1 -1;2 -1 -1 -1];
case 3
	ttext = 'NASA Style Array'
	vecs = [eye(3) [1;1;1]/sqrt(3)]/2;
case 4
	ttext = 'Cube'
	vecs = [1 0 0;0 1 0;0 0 1];
case 5
	ttext = 'Regular Tetrahedron'
	vecs = [-sin(acos(1/3))*sin(120*pi/180) sin(acos(1/3))*sin(120*pi/180) 0              0
             sin(acos(1/3))*cos(120*pi/180) sin(acos(1/3))*cos(120*pi/180) sin(acos(1/3)) 0
             1/3                            1/3                            1/3           -1 ]; 
case 6
	ttext = 'Uniform?'
	vecs = sqrt(1/3)*[1 1 -1 -1; 1 -1 -1 1; 1 1 1 1];    % Turns out to be identical to the regular tetra but for a rotation
case 7
	ttext = 'finalexam'
	vecs = A;
end
nvecs = size(vecs,2);  % number of vectors
%
% vertices
% get vertices built from all combinations of vectors and -vectors
nverts = 2^nvecs;
ivecs = bitget(repmat(linspace(0,nverts-1,nverts).',[1 nvecs]),repmat(1:nvecs,[nverts 1]));
ivecs = ivecs-~ivecs;   % index of vecs that will build verts, nverts x nvecs
% multiply (+1 or -1) vecs according to ivecs
% x * diag(sparse(y)), multiplies each row of x by the vector y
verts = reshape(repmat(ivecs,[3 1]),[nverts 3*nvecs]) * diag(sparse(vecs(:)));
% reshape and perform the vector sum
verts = sum(reshape(verts,[nverts 3 nvecs]),3); % verts is now nverts x 3

% convhulln
k = convhulln(verts);   % returns indices of vert sets, one per hull face
%
figure(1)
clf
%
subplot(2,2,1)
hdl = patch(reshape(verts(k.',1),3,[]),reshape(verts(k.',2),3,[]),reshape(verts(k.',3),3,[]),'b');
set(hdl,'facecolor',[1 1 1],'ambientstrength',.2,'facealpha',.8,'specularstrength',0.2,'diffusestrength',0.2,'specularexponent',1)
if ~exist('showedge'), showedge = 0; end
if ~showedge, set(hdl,'EdgeAlpha',0), end
lhdl=light('Position',[1  1  0]);
lhdl=light('Position',[1  0  1]);
lhdl=light('Position',[0  1  1]);
grid
view([1 0 0])
axis('equal')
xlabel('x')
ylabel('y')
zlabel('z')
%
subplot(2,2,2)
hdl = patch(reshape(verts(k.',1),3,[]),reshape(verts(k.',2),3,[]),reshape(verts(k.',3),3,[]),'b');
set(hdl,'facecolor',[1 1 1],'ambientstrength',.2,'facealpha',.8,'specularstrength',0.2,'diffusestrength',0.2,'specularexponent',1)
if ~exist('showedge'), showedge = 0; end
if ~showedge, set(hdl,'EdgeAlpha',0), end
lhdl=light('Position',[1  1  0]);
lhdl=light('Position',[1  0  1]);
lhdl=light('Position',[0  1  1]);
grid
view([0 1 0])
axis('equal')
xlabel('x')
ylabel('y')
zlabel('z')
%
subplot(2,2,3)
hdl = patch(reshape(verts(k.',1),3,[]),reshape(verts(k.',2),3,[]),reshape(verts(k.',3),3,[]),'b');
set(hdl,'facecolor',[1 1 1],'ambientstrength',.2,'facealpha',.8,'specularstrength',0.2,'diffusestrength',0.2,'specularexponent',1)
if ~exist('showedge'), showedge = 0; end
if ~showedge, set(hdl,'EdgeAlpha',0), end
lhdl=light('Position',[1  1  0]);
lhdl=light('Position',[1  0  1]);
lhdl=light('Position',[0  1  1]);
grid
view([0 0 1])
axis('equal')
xlabel('x')
ylabel('y')
zlabel('z')
%
subplot(2,2,4)
hdl = patch(reshape(verts(k.',1),3,[]),reshape(verts(k.',2),3,[]),reshape(verts(k.',3),3,[]),'b');
set(hdl,'facecolor',[1 1 1],'ambientstrength',.2,'facealpha',1,'specularstrength',0.2,'diffusestrength',0.2,'specularexponent',2)
if ~exist('showedge'), showedge = 0; end
if ~showedge, set(hdl,'EdgeAlpha',0), end
lhdl=light('Position',[1  1  0]);
lhdl=light('Position',[1  0  1]);
lhdl=light('Position',[0  1  1]);
grid
view([1 2 3])
axis('equal')
xlabel('x')
ylabel('y')
zlabel('z')
%
