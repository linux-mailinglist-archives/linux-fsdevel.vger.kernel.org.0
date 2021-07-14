Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA953C7ABE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 03:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbhGNBDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 21:03:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:34347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237180AbhGNBDl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626224428;
        bh=VChibxoLx6Jc0jNuRE9DDxLJE+G6pF+f6gIyZZYjdUk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O75YU8io9QTTb4cNVm5rEKrVmBfDM6oP/d3UBu5MMQ5z0eY8W84myXljoOer9z4Gl
         hWJfJL62bbhBCvJ/1ecohDx2lmIV7D9Jag48thrx50WrpXjKmqkpxj4/tVxlpj3Bzf
         EAXysjvnhINJyVMDGle3RR3r9zTriG9UwZxHmeEg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhU9j-1lYW1w3jnP-00egvP; Wed, 14
 Jul 2021 03:00:28 +0200
Subject: Re: [PATCH 17/24] btrfs/ioctl: allow idmapped
 BTRFS_IOC_SNAP_DESTROY{_V2} ioctl
To:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
 <20210713111344.1149376-18-brauner@kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <82945186-1373-fc09-0afd-60d40dc71868@gmx.com>
Date:   Wed, 14 Jul 2021 09:00:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713111344.1149376-18-brauner@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i4GV977pxKOtlypIPQ83tmFJV5CEuoOJt/vixN/JzNzHT6fxmfC
 R2Wm+4vflMY4+asTeJG/O2LelZ0HAvghjdDs5HltYZy8/eavi/PAwU/0Up3UABQYTNdBX+X
 jii/Y7Qck/5hn7VVtHmYTV3Bj7ukF/fHAFPVI4OYC4s9bS+7Ib+MiqvmTVyVa7ce6/+SWh0
 rrdScbMcNY43pZF4SNGCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nsyLeidVQs4=:pIkQOjTu8WsQlwyK4VxTL3
 vERoNMmbJSrasd5eV+lc9/BaEfgpOEH+GSjGlT3pp6Ro/aD0/mJOsidPs2tLSWUefttv9vjyV
 rbqiC+y4RkgqGiUr8hdNMOARDpMVJroZp3tN6rmPgvdTUFItYiYiOi+lHHmrowPOTPMH/huAj
 tsVhyHNRuihAwBstOZBwz9fKe09N0aWVysvIkiYmhlF92f4FokrACX4qa/bHIIlTBh13gARYR
 uCa8AtgUH5/WwvIKZiJRyhh1X5hmg3i3vaTUWlCj61I7YMO41E+PWp/gh/lFLRNyDf4jvjvv2
 91CH2abDi9Tk2ep4m1iYdFW8dyrSre+LK2ox6J3b2k0kD3zvg2299XMij7cKF8A4AA0cRN6NY
 +p1GXzBw6a2411222YNwBOb35VhNpKGmlkdWTWgFmsggH45GznxzMXJCMLogF7vRuZzk+dQ1a
 5TKr7bgKHL3cvnyhNBYXLqPjXkt0BBLcAsT0c/kTT1xcFYv9mPRHME2+2ixHq40nUvqtRdEgR
 abSECS9b8CQ5IG8Fd104x4ePoxa0C748E4VUWn+ufOzzLnbqUILX55QRSTABGDF7n96Y/dgyQ
 sEWJP9nkxjdY/hspRL+v48lkGMyxaMhj3uzrPJ9e+zIJXAGRlFsD4eOi48IIRfPWvtWWZW0Sf
 GIO63TP1rgNlfN9OANwprwllvZSjJVpDLDbM1PFmBhNpfgS3vcu3nut0L5fQUI+3UzPMwdxq+
 migvukGotnixpLRObV0yB5m5I2q4cX6oOWSbM34TZElUTeOek6IJcYgjPsVVuJ0/nZ7zoFbmZ
 Rtqm7ydRq2udFHf3aImBBNC0aNOv9AAG/NUKEwCYkqHJengREN1VUEMWRLqXK5v8bBnG2kw2r
 P6qJZl5GK5OqSLy8RQ1DRSU80t3VoJcFKwKwe1kRnppRqh+2zm2yAEYstH40cgQPmC451Bq3s
 JMJ0z0Ix+2gvVw5l15BOXWgOXOcnF4GJDrOKTLpo1hGlFvlQCx8W5Dx0IK+r/jQejEzNwyQqN
 jvJj1eh09Oj0ZHBeaCgVRc6XLoJtAlQqm6J/nq36/T6pvd56ZAfI2t5jxb3IEUBEol/lmybfC
 Z6RN/pyt14LXRWTnP6CYzW/afkjeloVZtpoIxqrqMZfrNsCe3FaTiSMSA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/7/13 =E4=B8=8B=E5=8D=887:13, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Destroying subvolumes and snapshots are important features of btrfs. Bot=
h
> operations are available to unprivileged users if the filesystem has bee=
n
> mounted with the "user_subvol_rm_allowed" mount option. Allow subvolume =
and
> snapshot deletion on idmapped mounts. This is a fairly straightforward
> operation since all the permission checking helpers are already capable =
of
> handling idmapped mounts. So we just need to pass down the mount's usern=
s.
>
> In addition to regular subvolume or snapshot deletion by specifying the =
name of
> the subvolume or snapshot the BTRFS_IOC_SNAP_DESTROY_V2 ioctl allows the
> deletion of subvolumes and snapshots via subvolume and snapshot ids when=
 the
> BTRFS_SUBVOL_SPEC_BY_ID flag is raised.
>
> This feature is blocked on idmapped mounts as this allows filesystem wid=
e
> subvolume deletions and thus can escape the scope of what's exposed unde=
r the
> mount identified by the fd passed with the ioctl.
>
> Here is an example where a btrfs subvolume is deleted through a subvolum=
e mount
> that does not expose the subvolume to be delete but it can still be dele=
ted by
> using the subvolume id:
>
>   /* Compile the following program as "delete_by_spec". */
>
>   #define _GNU_SOURCE
>   #include <fcntl.h>
>   #include <inttypes.h>
>   #include <linux/btrfs.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <sys/ioctl.h>
>   #include <sys/stat.h>
>   #include <sys/types.h>
>   #include <unistd.h>
>
>   static int rm_subvolume_by_id(int fd, uint64_t subvolid)
>   {
>   	struct btrfs_ioctl_vol_args_v2 args =3D {};
>   	int ret;
>
>   	args.flags =3D BTRFS_SUBVOL_SPEC_BY_ID;
>   	args.subvolid =3D subvolid;
>
>   	ret =3D ioctl(fd, BTRFS_IOC_SNAP_DESTROY_V2, &args);
>   	if (ret < 0)
>   		return -1;
>
>   	return 0;
>   }
>
>   int main(int argc, char *argv[])
>   {
>   	int subvolid =3D 0;
>
>   	if (argc < 3)
>   		exit(1);
>
>   	fprintf(stderr, "Opening %s\n", argv[1]);
>   	int fd =3D open(argv[1], O_CLOEXEC | O_DIRECTORY);
>   	if (fd < 0)
>   		exit(2);
>
>   	subvolid =3D atoi(argv[2]);
>
>   	fprintf(stderr, "Deleting subvolume with subvolid %d\n", subvolid);
>   	int ret =3D rm_subvolume_by_id(fd, subvolid);
>   	if (ret < 0)
>   		exit(3);
>
>   	exit(0);
>   }
>   #include <stdio.h>"
>   #include <stdlib.h>"
>   #include <linux/btrfs.h"
>
>   truncate -s 10G btrfs.img
>   mkfs.btrfs btrfs.img
>   export LOOPDEV=3D$(sudo losetup -f --show btrfs.img)
>   mount ${LOOPDEV} /mnt
>   sudo chown $(id -u):$(id -g) /mnt
>   btrfs subvolume create /mnt/A
>   btrfs subvolume create /mnt/B/C
>   # Get subvolume id via:
>   sudo btrfs subvolume show /mnt/A
>   # Save subvolid
>   SUBVOLID=3D<nr>
>   sudo umount /mnt
>   sudo mount ${LOOPDEV} -o subvol=3DB/C,user_subvol_rm_allowed /mnt
>   ./delete_by_spec /mnt ${SUBVOLID}
>
> With idmapped mounts this can potentially be used by users to delete
> subvolumes/snapshots they would otherwise not have access to as the idma=
pping
> would be applied to an inode that is not exposed in the mount of the sub=
volume.
>
> The fact that this is a filesystem wide operation suggests it might be a=
 good
> idea to expose this under a separate ioctl that clearly indicates this. =
In
> essence, the file descriptor passed with the ioctl is merely used to ide=
ntify
> the filesystem on which to operate when BTRFS_SUBVOL_SPEC_BY_ID is used.
>
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>   fs/btrfs/ioctl.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 31115083f382..dd0fabdbeeeb 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -830,7 +830,8 @@ static int create_snapshot(struct btrfs_root *root, =
struct inode *dir,
>    *     nfs_async_unlink().
>    */
>
> -static int btrfs_may_delete(struct inode *dir, struct dentry *victim, i=
nt isdir)
> +static int btrfs_may_delete(struct user_namespace *mnt_userns,
> +			    struct inode *dir, struct dentry *victim, int isdir)
>   {
>   	int error;
>
> @@ -840,12 +841,12 @@ static int btrfs_may_delete(struct inode *dir, str=
uct dentry *victim, int isdir)
>   	BUG_ON(d_inode(victim->d_parent) !=3D dir);
>   	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
>
> -	error =3D inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
> +	error =3D inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
>   	if (error)
>   		return error;
>   	if (IS_APPEND(dir))
>   		return -EPERM;
> -	if (check_sticky(&init_user_ns, dir, d_inode(victim)) ||
> +	if (check_sticky(mnt_userns, dir, d_inode(victim)) ||
>   	    IS_APPEND(d_inode(victim)) || IS_IMMUTABLE(d_inode(victim)) ||
>   	    IS_SWAPFILE(d_inode(victim)))
>   		return -EPERM;
> @@ -2914,6 +2915,7 @@ static noinline int btrfs_ioctl_snap_destroy(struc=
t file *file,
>   	struct btrfs_root *dest =3D NULL;
>   	struct btrfs_ioctl_vol_args *vol_args =3D NULL;
>   	struct btrfs_ioctl_vol_args_v2 *vol_args2 =3D NULL;
> +	struct user_namespace *mnt_userns =3D file_mnt_user_ns(file);
>   	char *subvol_name, *subvol_name_ptr =3D NULL;
>   	int subvol_namelen;
>   	int err =3D 0;
> @@ -2941,6 +2943,18 @@ static noinline int btrfs_ioctl_snap_destroy(stru=
ct file *file,
>   			if (err)
>   				goto out;
>   		} else {
> +			/*
> +			 * Deleting by subvolume id can be used to delete
> +			 * subvolumes/snapshots anywhere in the filesystem.
> +			 * Ensure that users can't abuse idmapped mounts of
> +			 * btrfs subvolumes/snapshots to perform operations in
> +			 * the whole filesystem.
> +			 */
> +			if (mnt_userns !=3D &init_user_ns) {
> +				err =3D -EINVAL;
> +				goto out;
> +			}

I'm OK to disable subvolume deletion by subvolid for now as a workaround.

In fact, for idmapped environment, if using btrfs-progs to delete
subvolume, it will do the root backref lookup, and if it can't do that,
it will abort the deletion.

Although the ultimate solution would be to make root backref lookup to
idmap compatible.

For a valid subvolume deletion, it needs to find the dentry of the root,
just like below you can see the related code:

                         dentry =3D btrfs_get_dentry(fs_info->sb,
                                         BTRFS_FIRST_FREE_OBJECTID,
                                         vol_args2->subvolid, 0, 0);
                         if (IS_ERR(dentry)) {
                                 err =3D PTR_ERR(dentry);
                                 goto out_drop_write;
                         }

Not sure how hard it would be, but I guess it may be a big project.

Thanks,
Qu

> +
>   			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID) {
>   				err =3D -EINVAL;
>   				goto out;
> @@ -3025,7 +3039,7 @@ static noinline int btrfs_ioctl_snap_destroy(struc=
t file *file,
>   	err =3D down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
>   	if (err =3D=3D -EINTR)
>   		goto free_subvol_name;
> -	dentry =3D lookup_one_len(&init_user_ns, subvol_name, parent, subvol_n=
amelen);
> +	dentry =3D lookup_one_len(mnt_userns, subvol_name, parent, subvol_name=
len);
>   	if (IS_ERR(dentry)) {
>   		err =3D PTR_ERR(dentry);
>   		goto out_unlock_dir;
> @@ -3067,14 +3081,14 @@ static noinline int btrfs_ioctl_snap_destroy(str=
uct file *file,
>   		if (root =3D=3D dest)
>   			goto out_dput;
>
> -		err =3D inode_permission(&init_user_ns, inode,
> +		err =3D inode_permission(mnt_userns, inode,
>   				       MAY_WRITE | MAY_EXEC);
>   		if (err)
>   			goto out_dput;
>   	}
>
>   	/* check if subvolume may be deleted by a user */
> -	err =3D btrfs_may_delete(dir, dentry, 1);
> +	err =3D btrfs_may_delete(mnt_userns, dir, dentry, 1);
>   	if (err)
>   		goto out_dput;
>
>
