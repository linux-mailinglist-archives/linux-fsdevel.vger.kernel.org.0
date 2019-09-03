Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2169DA6927
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 15:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfICNAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 09:00:02 -0400
Received: from sonic313-20.consmr.mail.ir2.yahoo.com ([77.238.179.187]:42710
        "EHLO sonic313-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbfICNAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567515599; bh=Ymx6zesD8kcqqF5CXirBlYd3aOKGTZafIB2LQkvzV+M=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=CyIO/pdfJ+u4ZSQkkzZq6RCT+RBZ9ssuICnDYuPF0FTL5cf2BMxyxKzrCeoCRExQ1clLDOnMJXz5KbhFg/FRagzO6pTpHMAYZHdx0/feGBrYag6j8eULCBErTG0cgVrql8bME4H3fp/AlI1hRmvXv/YFZj+NHahPhctosOs7FK+DYGhaw8zlNCyInXtUhUKoTi1rQtkJ0d3hKEy2VYb0CLUIsUDRlUXhyQ76x27wAxMWUbd/+RpCgsN5FHVdWaWfiPK88/L9zhD4pMZep9yhkeWqjNk0D5njCShYyGOLoMhr5EOje5oA/JvNQr18UWzobiRPum6lUbZ9MO4O7h7c7w==
X-YMail-OSG: EdiGaOMVM1n.7aMB1h6uSLEptMWR.jmr5ZZ5TaJMaBvZPyrJTWQSI46t9EXE.y0
 kAzp39O3Yli4BmJoJIfLqdBin6aMEAJC61xXRDyfXuDllYfCWYC8ZUePAp25.AG2BPy_OQHDE1He
 0WC2abuYhyZ3NLl3Iu9IAzQGi5J3x1K1iGSkrP7w5hiJdGMfjDwS9FpYhg8KXk5wl_6iOVvfVmjy
 uTiHzRxaXvh7c5tK6wccP25NwaqfeGWAs4jPqxYdpX2TRcuNVxqbWBOXJ0.1SVxQkYaMN_oWbjmo
 Rsb4vIkpsXwfDrK0kLC3Ypv1KZ1.esnvRjPcA0luvZFdROeJyvquhp1__r6Sj8RK8RwOFwT0.185
 ObLN.bFMP6p96m70mjDKnXrRvJuEiRS209IEOJeXFhboQuogdIDpqRSx0JkYRK2cgVGybbJ6BOsd
 qQGCKEObSJzfFwJxxRbVWaLeFEWiC_eA2R81YPmmgy6VCg3g49dFt8Ow674GpGD3uEDvzUYrH7L5
 vgZ0fO5HURu3ppE8r46OBvGi7a_jJ93w_Kfo6u6ahTBarCSUdUMQ7kaRasplsw3T8hqCYjhU_A2Q
 qYZ34LPKm62GL8luq49d05QjNzE__0l0AEfnDSLz5kTCG3fqBNMxX.R3qhi5ZYlxlA5r6jc.vpNv
 W3U3JaO4pB1iaUvbwmQeSdbMJ2AAfo7bWpDITVKXewTD_qJn.dxq.RfcIbRSGz7D1KLJn9WV9hMU
 rQ_q1J_Ia8g7UHq38gkUGXtCEmxptKK7m68BhL94MBc0U7IOSr_VIFfw7qc0oKrK_b7hTB28PDgP
 Xtr_x81izA9eU7t7lgg0eP2lhPymtEx1v4_.netUYBVwLkzegrIgWu06YrAMr56ur4FH9xfLvveX
 _wrre0POnUAKyuZ3hRf4kXcqJa9XCQrq9gqB.LzIxxf7pdGMzAPvc7i9ko_Jnjkum8GdMHb9Krjs
 Xbg9Sm52VN4kDL25Z7QpIqaDOenTfiP101ni4kTWY3Epai_oRQqNw7.4F9F2jl052XNqnDb8Smet
 LqGQHr5s_crAeDP_31wrhXgINpsoUXIZyirnsUjDc9sNJ9pKrRdO9ZIRlrwKSvFp4XvsyNu.feDF
 Mp3pkPEnSDRyWWEyyCEhBkE2EH816DirjaKSqk32euDMtBFPzD_kA4xfndRwsBjD_4ru0EIjCQyv
 K9ABR6EngfvawJNm1OL4IVQPml6LF_SQnfzUS8blgzY4Bp4oMttpk6ysXRL.6tdbtGrb0Fz4gdgP
 ku1XKfGtQIXrbKBTgRvdmEAqrJw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Tue, 3 Sep 2019 12:59:59 +0000
Received: by smtp426.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 285e9a0bdd248d36e5bdc2a417a228bb;
          Tue, 03 Sep 2019 12:59:55 +0000 (UTC)
Date:   Tue, 3 Sep 2019 20:59:47 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        aneesh.kumar@linux.ibm.com, Jeff Layton <jlayton@kernel.org>,
        wugyuan@cn.ibm.com
Subject: Re: [RFC] - vfs: Null pointer dereference issue with symlink create
 and read of symlink
Message-ID: <20190903125946.GA11069@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190903115827.0A8A0A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903115827.0A8A0A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 05:28:26PM +0530, Ritesh Harjani wrote:
> Hi Viro/All,
> 
> Could you please review below issue and it's proposed solutions.
> If you could let me know which of the two you think will be a better
> approach to solve this or in case if you have any other better approach, I
> can prepare and submit a official patch with that.
> 
> 
> 
> Issue signature:-
>  [NIP  : trailing_symlink+80]
>  [LR   : trailing_symlink+1092]
>  #4 [c00000198069bb70] trailing_symlink at c0000000004bae60  (unreliable)
>  #5 [c00000198069bc00] path_openat at c0000000004bdd14
>  #6 [c00000198069bc90] do_filp_open at c0000000004c0274
>  #7 [c00000198069bdb0] do_sys_open at c00000000049b248
>  #8 [c00000198069be30] system_call at c00000000000b388
> 
> 
> 
> Test case:-
> shell-1 - "while [ 1 ]; do cat /gpfs/g1/testdir/file3; sleep 1; done"
> shell-2 - "while [ 1 ]; do ln -s /gpfs/g1/testdir/file1
> /gpfs/g1/testdir/file3; sleep 1; rm /gpfs/g1/testdir/file3 sleep 1; done
> 
> 
> 
> Problem description:-
> In some filesystems like GPFS below described scenario may happen on some
> platforms (Reported-By:- wugyuan)
> 
> Here, two threads are being run in 2 different shells. Thread-1(cat) does
> cat of the symlink and Thread-2(ln) is creating the symlink.
> 
> Now on any platform with GPFS like filesystem, if CPU does out-of-order
> execution (or any kind of re-ordering due compiler optimization?) in
> function __d_set_and_inode_type(), then we see a NULL pointer dereference
> due to inode->i_uid.
> 
> This happens because in lookup_fast in nonRCU path or say REF-walk (i.e. in
> else condition), we check d_is_negative() without any lock protection.
> And since in __d_set_and_inode_type() re-ordering may happen in setting of
> dentry->type & dentry->inode => this means that there is this tiny window
> where things are going wrong.
> 
> 
> (GPFS like):- Any FS with -inode_operations ->permission callback returning
> -ECHILD in case of (mask & MAY_NOT_BLOCK) may cause this problem to happen.
> (few e.g. found were - ocfs2, ceph, coda, afs)
> 
> int xxx_permission(struct inode *inode, int mask)
> {
>          if (mask & MAY_NOT_BLOCK)
>                  return -ECHILD;
> 	<...>
> }
> 
> Wugyuan(cc), could reproduce this problem with GPFS filesystem.
> Since, I didn't have the GPFS setup, so I tried replicating on a native FS
> by forcing out-of-order execution in function __d_set_inode_and_type() and
> making sure we return -ECHILD in MAY_NOT_BLOCK case in ->permission
> operation for all inodes.
> 
> With above changes in kernel, I could as well hit this issue on a native FS
> too.
> 
> (basically what we observed is link_path_walk will do nonRCU(REF-walk)
> lookup due to may_lookup -> inode_permission return -ECHILD and then
> unlazy_walk drops the LOOKUP_RCU flag (nd->flag). After that below race is
> possible).
> 
> 
> 
> Sequence of events:-
> 
> Thread-2(Comm: ln)		Thread-1(Comm: cat)
> 
> 				dentry = __d_lookup() //nonRCU
> 
> __d_set_and_inode_type() (Out-of-order execution)
> 	flags = READ_ONCE(dentry->d_flags);
> 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
> 	flags |= type_flags;
> 	WRITE_ONCE(dentry->d_flags, flags);
> 
> 					
> 				if (unlikely(d_is_negative()) // fails
>   					{}
> 				// since type is already updated in
> 				// Thread-2 in parallel but inode
> 				// not yet set.
> 				// d_is_negative returns false
> 
> 				*inode = d_backing_inode(path->dentry);
> 				// means inode is still NULL
> 
> 	dentry->d_inode = inode;
> 	
> 				trailing_symlink()
> 					may_follow_link()
> 						inode = nd->link_inode;
> 						// nd->link_inode = NULL
> 						//Then it crashes while
> 						//doing inode->i_uid
> 					
> 	

It seems much similar to
https://lore.kernel.org/r/20190419084810.63732-1-houtao1@huawei.com/

Thanks,
Gao Xiang

> 
> 
> 
> Approach-1:- using wmb()
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index e88cf0554e65..966172df77ee 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -316,6 +316,7 @@ static inline void __d_set_inode_and_type(struct dentry
> *dentry,
>         unsigned flags;
> 
>         dentry->d_inode = inode;
> +       smp_wmb();
>         flags = READ_ONCE(dentry->d_flags);
>         flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
>         flags |= type_flags;
> 
> 
> 
> Approach-2:- using spin_lock(&dentry->d_lock);
> 
> Do you think lock should be a better approach, given that we are already
> in REF-walk mode. As per the Documentation, we should be able to take
> spin_lock(&dentry->d_lock) in Ref-walk mode whenever required?
> 
> 
> With smp_wmb(), if added, should add a small latency in both
> RCU/REF-walk. But should be able to cover all the cases in general related
> to dentry->type & dentry->inode ordering. Though, we don't have any other
> race conditions reported or tested, other than the one, mentioned in this
> email.
> 
> Confused :(
> 
> 
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 209c51a5226c..a3145594da1c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1557,6 +1557,7 @@ static int lookup_fast(struct nameidata *nd,
>         struct dentry *dentry, *parent = nd->path.dentry;
>         int status = 1;
>         int err;
> +       bool negative;
> 
>         /*
>          * Rename seqlock is not required here because in the off chance
> @@ -1565,7 +1566,6 @@ static int lookup_fast(struct nameidata *nd,
>          */
>         if (nd->flags & LOOKUP_RCU) {
>                 unsigned seq;
> -               bool negative;
>                 dentry = __d_lookup_rcu(parent, &nd->last, &seq);
>                 if (unlikely(!dentry)) {
>                         if (unlazy_walk(nd))
> @@ -1623,7 +1623,11 @@ static int lookup_fast(struct nameidata *nd,
>                 dput(dentry);
>                 return status;
>         }
> -       if (unlikely(d_is_negative(dentry))) {
> +
> +       spin_lock(&dentry->d_lock);
> +       negative = d_is_negative(dentry);
> +       spin_unlock(&dentry->d_lock);
> +       if (unlikely(negative)) {
>                 dput(dentry);
>                 return -ENOENT;
>         }
> 
> 
> Regards
> Ritesh
> 
