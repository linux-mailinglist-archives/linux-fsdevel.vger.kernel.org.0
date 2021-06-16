Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2685A3A930E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 08:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhFPGvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 02:51:04 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:56715 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFPGvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:51:03 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210616064855epoutp04dfa835353eb24aace5a1c3b6e498dc81~I-URSVh6d0366103661epoutp04Y
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 06:48:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210616064855epoutp04dfa835353eb24aace5a1c3b6e498dc81~I-URSVh6d0366103661epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623826135;
        bh=5VUzp4QPfNBa7NOcRe1Lk7tImGAGi3caiwYRjxR04I4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=kx4twsJhAduqnI1lZysNcXRBTW0PoTFp4IBiNb6xGacOILoNf5+lrGLrWk1X3jsEw
         AxGL8H3u5Lk1J0mhIAtx0nWMLDXGyfWcvgtLr3H+Q1hNWZu/gZ7Z7HeDKi0cVJElwf
         zVg9UqsbHFgP+z6DHz8EI0m3zvpATlWidfpaiWxQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210616064854epcas1p2447de00835818a5dd59067e761368d03~I-UQweofm2236422364epcas1p2X;
        Wed, 16 Jun 2021 06:48:54 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4G4bPd6xmPz4x9Q8; Wed, 16 Jun
        2021 06:48:53 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.9C.09824.5DE99C06; Wed, 16 Jun 2021 15:48:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210616064853epcas1p298e462347aee43fee38fb40003b2aba8~I-UPF0flW1876518765epcas1p2c;
        Wed, 16 Jun 2021 06:48:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210616064853epsmtrp25b7a042009ebd0cebac6e486518a1232~I-UPD4Yo13132731327epsmtrp2z;
        Wed, 16 Jun 2021 06:48:53 +0000 (GMT)
X-AuditID: b6c32a37-621e9a8000002660-3e-60c99ed5cd04
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.D8.08163.4DE99C06; Wed, 16 Jun 2021 15:48:52 +0900 (KST)
Received: from namjaejeon01 (unknown [10.89.31.77]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210616064852epsmtip19fbaeabf3b588d4c0cac437644734a82~I-UOj6CeV0932709327epsmtip12;
        Wed, 16 Jun 2021 06:48:52 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Christoph Hellwig'" <hch@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>, <smfrench@gmail.com>,
        <stfrench@microsoft.com>, <willy@infradead.org>,
        <aurelien.aptel@gmail.com>,
        <linux-cifsd-devel@lists.sourceforge.net>,
        <senozhatsky@chromium.org>, <sandeen@sandeen.net>,
        <aaptel@suse.com>, <viro@zeniv.linux.org.uk>,
        <ronniesahlberg@gmail.com>, <hch@lst.de>,
        <dan.carpenter@oracle.com>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Hyunchul Lee'" <hyc.lee@gmail.com>
In-Reply-To: <YMhpG/sAjO3WKKc3@infradead.org>
Subject: RE: [PATCH v4 08/10] cifsd: add file operations
Date:   Wed, 16 Jun 2021 15:48:52 +0900
Message-ID: <009c01d7627b$ab8d69b0$02a83d10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJhIpvEjjDPMdIB0j/UYsSOvpftcQHigYlUAdgsEtICVUebFKnRxsew
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJsWRmVeSWpSXmKPExsWy7bCmge7VeScTDA48NbVofHuaxeL467/s
        Fq//TWexOD1hEZPFytVHmSyu3X/PbvHi/y5mi5//vzNa7Nl7ksXi8q45bBa9fZ9YLVqvaFns
        3riIzWLt58fsFm9eHGazuDVxPpvF+b/HWS1+/5jD5iDkMbvhIovHzll32T02r9Dy2L3gM5PH
        7psNbB6tO/6ye3x8eovFY8vih0we67dcZfH4vEnOY9OTt0wB3FE5NhmpiSmpRQqpecn5KZl5
        6bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAnykplCXmlAKFAhKLi5X07WyK8ktL
        UhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEqE3Iy2hdNZC74HF/x8q5+A2OP
        VxcjJ4eEgInE0gfzmboYuTiEBHYwSvzfdIIRwvnEKLFyfiMrhPOZUWLj7h6WLkYOsJZ9B4Uh
        4rsYJU48/gfV8YJRontxNyPIXDYBXYl/f/azgdgiQPbZhS/AipgFGlkkNrw9yQSS4ARKXJ+9
        hwlkqrCAhcT+Cc4gYRYBVYm9hyazgti8ApYSRzfsZIawBSVOznzCAmIzC8hLbH87hxniBwWJ
        n0+XsYKMERFwk5i9JBSiRERidmcbM8haCYHJnBILFx9ih3jARWLbVU2IVmGJV8e3sEPYUhKf
        3+1lg7DLJU6c/MUEYddIbJi3D6rVWKLnRQmIySygKbF+lz5EhaLEzt9zGSG28km8+9rDClHN
        K9HRJgRRoirRd+kw1EBpia72D+wTGJVmIXlrFpK3ZiG5fxbCsgWMLKsYxVILinPTU4sNC4yR
        I3oTIzjFa5nvYJz29oPeIUYmDsZDjBIczEoivLrFJxKEeFMSK6tSi/Lji0pzUosPMZoCA3oi
        s5Rocj4wy+SVxBuaGhkbG1uYmJmbmRorifPuZDuUICSQnliSmp2aWpBaBNPHxMEp1cCUfeVE
        1iOnuZvvca5LDH7nIuy/UyV/6uWny96kvQoqPVLvMO3T9BOhT/apl4jWun9R+Dzp2nuW6+YP
        mfXC9BvOWRgXvvdalvrmuOTs+1oHVaQD7/+z/xTkxvBv6+5yq69XlWelMbNfa9KteZnupuHp
        UVhd5TXNkPdOf5i1U8/TP1YFLFvW1TPuXyztf9tQ+kHVheSqx7ddgop9F5pmKO9p4qw3rpy/
        hn0+x885T83FgzXrdVapflBtnnCPJz1vU+OiyZZ1ZwwymNgt/vpMDEv6eUzY5Lukd9dlY+Wl
        Wt8vPv/EFqCYtD1fLeEBn/y6O5f0PnNpnP9y4No7P7/46TsnCXXOOuYVd/+OvYHd9hAlluKM
        REMt5qLiRABoxK+AegQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCSnO7VeScTDE6lWDS+Pc1icfz1X3aL
        1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2i96+T6wWrVe0LHZv
        XMRmsfbzY3aLNy8Os1ncmjifzeL83+OsFr9/zGFzEPKY3XCRxWPnrLvsHptXaHnsXvCZyWP3
        zQY2j9Ydf9k9Pj69xeKxZfFDJo/1W66yeHzeJOex6clbpgDuKC6blNSczLLUIn27BK6M9kUT
        mQs+x1e8vKvfwNjj1cXIwSEhYCKx76BwFyMXh5DADkaJxs8nmLoYOYHi0hLHTpxhhqgRljh8
        uBii5hmjxLJF29hBatgEdCX+/dnPBmKLANlnF75gBCliFpjMIrHrN0gRSMc9RonuiT/AOjiB
        qq7P3sMEMlVYwEJi/wRnkDCLgKrE3kOTWUFsXgFLiaMbdjJD2IISJ2c+YQEpZxbQk2jbyAgS
        ZhaQl9j+dg4zxJ0KEj+fLmMFKRERcJOYvSQUokREYnZnG/MERuFZSAbNQhg0C8mgWUg6FjCy
        rGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI50La0djHtWfdA7xMjEwXiIUYKDWUmE
        V7f4RIIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTH55
        y5g2bpU0nmZy5s/7GokX501CuENjjW2rHPh0Ag7bSO7jeZDDuT9bqehi9L+eG//b45KXhad7
        8+11t5n2jTFD56tllJHc1sMSl570BOjMzoxpVi1NOZW6e7F3hEd6ft98ZqnlN2Y9iWThN/a+
        Ffz4546Oa66LxWZ/d1L/s7Ltc8wfVmP1jFOpTza8PqX7++MG0xWqtxIVG3SsqzLv7rJ4eKWU
        /eTDex1Nn+Qdjjle09xw4o5XqJ1gzL0V7h59331XT8mMauzYftGht+CNnejrYg/RiV8YfjD2
        rDry1tpYxCdwTV9UsfayD6lXD8sbr/riIMXf/ObA7YTDHdb7/13R2ZL5uibMpjbgDk+fEktx
        RqKhFnNRcSIAR5102GMDAAA=
X-CMS-MailID: 20210616064853epcas1p298e462347aee43fee38fb40003b2aba8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210602035820epcas1p3c444b34a6b6a4252c9091e0bf6c0c167
References: <20210602034847.5371-1-namjae.jeon@samsung.com>
        <CGME20210602035820epcas1p3c444b34a6b6a4252c9091e0bf6c0c167@epcas1p3.samsung.com>
        <20210602034847.5371-9-namjae.jeon@samsung.com>
        <YMhpG/sAjO3WKKc3@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Wed, Jun 02, 2021 at 12:48:45PM +0900, Namjae Jeon wrote:
> > +#include <linux/rwlock.h>
> > +
> > +#include "glob.h"
> > +#include "buffer_pool.h"
> > +#include "connection.h"
> > +#include "mgmt/ksmbd_ida.h"
> > +
> > +static struct kmem_cache *filp_cache;
> > +
> > +struct wm {
> > +	struct list_head	list;
> > +	unsigned int		sz;
> > +	char			buffer[0];
> 
> This should use buffer[];
Okay.

> 
> > +};
> > +
> > +struct wm_list {
> > +	struct list_head	list;
> > +	unsigned int		sz;
> > +
> > +	spinlock_t		wm_lock;
> > +	int			avail_wm;
> > +	struct list_head	idle_wm;
> > +	wait_queue_head_t	wm_wait;
> > +};
> 
> What does wm stand for?
> 
> This looks like arbitrary caching of vmalloc buffers.  I thought we decided to just make vmalloc suck
> less rather than papering over that?
Today I have checked that vmalloc performance improvement patch for big allocation is merged.
I will remove it on next version.

> 
> > +static LIST_HEAD(wm_lists);
> > +static DEFINE_RWLOCK(wm_lists_lock);
> 
> Especially as this isn't going to scale at all using global loists and locks.
Okay.

> 
> > +void ksmbd_free_file_struct(void *filp) {
> > +	kmem_cache_free(filp_cache, filp);
> > +}
> > +
> > +void *ksmbd_alloc_file_struct(void)
> > +{
> > +	return kmem_cache_zalloc(filp_cache, GFP_KERNEL); }
> 
> These are only ued in vfs_cache.c . So I'd suggest to just move filp_cache there and drop these
> wrappers.
Okay.

> 
> > +}
> > +
> > +static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
> > +				    struct inode *parent_inode,
> > +				    struct inode *inode)
> > +{
> > +	if (!test_share_config_flag(work->tcon->share_conf,
> > +				    KSMBD_SHARE_FLAG_INHERIT_OWNER))
> > +		return;
> > +
> > +	i_uid_write(inode, i_uid_read(parent_inode)); }
> 
> Can you explain this a little more?  When do the normal create/mdir fail to inherit the owner?
The ownership of new files and directories is normally created with effective uid of the connected user.
There is "inherit owner" parameter(samba also have same one) to inherit the ownership of the parent directory.

> 
> int ksmbd_vfs_inode_permission(struct dentry *dentry, int acc_mode, bool delete)
> > +{
> > +	int mask, ret = 0;
> > +
> > +	mask = 0;
> > +	acc_mode &= O_ACCMODE;
> > +
> > +	if (acc_mode == O_RDONLY)
> > +		mask = MAY_READ;
> > +	else if (acc_mode == O_WRONLY)
> > +		mask = MAY_WRITE;
> > +	else if (acc_mode == O_RDWR)
> > +		mask = MAY_READ | MAY_WRITE;
> 
> How about already setting up the MAY_ flags in smb2_create_open_flags and returning them in extra
> argument?  That keeps the sm to Linux translation in a single place.
Right. Will update it.

> 
> > +
> > +	if (inode_permission(&init_user_ns, d_inode(dentry), mask | MAY_OPEN))
> > +		return -EACCES;
> 
> And this call can be open coded in the only caller.
Okay.

> 
> > +	if (delete) {
> 
> And this block could be split into a nice self-contained helper.
Okay.

> 
> > +		struct dentry *child, *parent;
> > +
> > +		parent = dget_parent(dentry);
> > +		inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> > +		child = lookup_one_len(dentry->d_name.name, parent,
> > +				       dentry->d_name.len);
> > +		if (IS_ERR(child)) {
> > +			ret = PTR_ERR(child);
> > +			goto out_lock;
> > +		}
> > +
> > +		if (child != dentry) {
> > +			ret = -ESTALE;
> > +			dput(child);
> > +			goto out_lock;
> > +		}
> > +		dput(child);
> 
> That being said I do not understand the need for this re-lookup at all.
Al commented parent could be not stable, So checked staleness by re-lookup name under parent lock.

> 
> > +	if (!inode_permission(&init_user_ns, d_inode(dentry), MAY_OPEN |
> > +MAY_WRITE))
> 
> All these inode_permission lines have overly long lines.  It might be worth to pass the user_namespace
> to this function, not only to shorten the code, but also to prepare for user namespace support.
Okay, Let me check it.

> 
> > +	parent = dget_parent(dentry);
> > +	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> > +	child = lookup_one_len(dentry->d_name.name, parent,
> > +			       dentry->d_name.len);
> > +	if (IS_ERR(child)) {
> > +		ret = PTR_ERR(child);
> > +		goto out_lock;
> > +	}
> > +
> > +	if (child != dentry) {
> > +		ret = -ESTALE;
> > +		dput(child);
> > +		goto out_lock;
> > +	}
> > +	dput(child);
> 
> This is the same weird re-lookup dance as above.  IFF there is a good rationale for it it needs to go
> into a self-contained and well documented helper.
Okay.

> 
> > +int ksmbd_vfs_create(struct ksmbd_work *work, const char *name,
> > +umode_t mode) {
> > +	struct path path;
> > +	struct dentry *dentry;
> > +	int err;
> > +
> > +	dentry = kern_path_create(AT_FDCWD, name, &path, 0);
> 
> Curious:  why is this using absolute or CWD based path instead of doing lookups based off the parent
> as done by e.g. nfsd?  Same also for mkdir and co.
Because SMB create request is given an absolute path unlike NFS.

> 
> > +{
> > +	struct file *filp;
> > +	ssize_t nbytes = 0;
> > +	char *rbuf;
> > +	struct inode *inode;
> > +
> > +	rbuf = work->aux_payload_buf;
> > +	filp = fp->filp;
> > +	inode = file_inode(filp);
> 
> These can be initialized on the declaration lines to make the code a little easier to read.
Okay.

> 
> > +	if (!work->tcon->posix_extensions) {
> > +		spin_lock(&src_dent->d_lock);
> > +		list_for_each_entry(dst_dent, &src_dent->d_subdirs, d_child) {
> > +			struct ksmbd_file *child_fp;
> > +
> > +			if (d_really_is_negative(dst_dent))
> > +				continue;
> > +
> > +			child_fp = ksmbd_lookup_fd_inode(d_inode(dst_dent));
> > +			if (child_fp) {
> > +				spin_unlock(&src_dent->d_lock);
> > +				ksmbd_debug(VFS, "Forbid rename, sub file/dir is in use\n");
> > +				return -EACCES;
> > +			}
> > +		}
> > +		spin_unlock(&src_dent->d_lock);
> > +	}
> 
> This begs for being split into a self-contained helper.
Okay.

> 
> > +int ksmbd_vfs_lock(struct file *filp, int cmd, struct file_lock
> > +*flock) {
> > +	ksmbd_debug(VFS, "calling vfs_lock_file\n");
> > +	return vfs_lock_file(filp, cmd, flock, NULL); }
> > +
> > +int ksmbd_vfs_readdir(struct file *file, struct ksmbd_readdir_data
> > +*rdata) {
> > +	return iterate_dir(file, &rdata->ctx); }
> > +
> > +int ksmbd_vfs_alloc_size(struct ksmbd_work *work, struct ksmbd_file *fp,
> > +			 loff_t len)
> > +{
> > +	smb_break_all_levII_oplock(work, fp, 1);
> > +	return vfs_fallocate(fp->filp, FALLOC_FL_KEEP_SIZE, 0, len); }
> 
> Please avoid such trivial wrappers that just make the code hard to follow.
Okay.

> 
> > +int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
> > +			 struct file_allocated_range_buffer *ranges,
> > +			 int in_count, int *out_count)
> 
> What is fqar?
It is an abbreviation for FSCTL QUERY ALLOCATED RANGES.

> 
> > +
> > +/*
> > + * ksmbd_vfs_get_logical_sector_size() - get logical sector size from
> > +inode
> > + * @inode: inode
> > + *
> > + * Return: logical sector size
> > + */
> > +unsigned short ksmbd_vfs_logical_sector_size(struct inode *inode) {
> > +	struct request_queue *q;
> > +	unsigned short ret_val = 512;
> > +
> > +	if (!inode->i_sb->s_bdev)
> > +		return ret_val;
> > +
> > +	q = inode->i_sb->s_bdev->bd_disk->queue;
> > +
> > +	if (q && q->limits.logical_block_size)
> > +		ret_val = q->limits.logical_block_size;
> > +
> > +	return ret_val;
> 
> I don't think a CIFS server has any business poking into the block layer.  What is this trying to do?
Ah, Yes, We don't need do that. I will change it with statfs->f_bsize.

> 
> > +struct posix_acl *ksmbd_vfs_posix_acl_alloc(int count, gfp_t flags) {
> > +#if IS_ENABLED(CONFIG_FS_POSIX_ACL)
> > +	return posix_acl_alloc(count, flags); #else
> > +	return NULL;
> > +#endif
> > +}
> > +
> > +struct posix_acl *ksmbd_vfs_get_acl(struct inode *inode, int type) {
> > +#if IS_ENABLED(CONFIG_FS_POSIX_ACL)
> > +	return get_acl(inode, type);
> > +#else
> > +	return NULL;
> > +#endif
> > +}
> > +
> > +int ksmbd_vfs_set_posix_acl(struct inode *inode, int type,
> > +			    struct posix_acl *acl)
> > +{
> > +#if IS_ENABLED(CONFIG_FS_POSIX_ACL)
> > +	return set_posix_acl(&init_user_ns, inode, type, acl); #else
> > +	return -EOPNOTSUPP;
> > +#endif
> > +}
> 
> Please avoid these pointless wrappers and just use large code block ifdefs or IS_ENABLED checks.
Okay.

> 
> > +int ksmbd_vfs_copy_file_range(struct file *file_in, loff_t pos_in,
> > +			      struct file *file_out, loff_t pos_out, size_t len) {
> > +	struct inode *inode_in = file_inode(file_in);
> > +	struct inode *inode_out = file_inode(file_out);
> > +	int ret;
> > +
> > +	ret = vfs_copy_file_range(file_in, pos_in, file_out, pos_out, len, 0);
> > +	/* do splice for the copy between different file systems */
> > +	if (ret != -EXDEV)
> > +		return ret;
> > +
> > +	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
> > +		return -EISDIR;
> > +	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
> > +		return -EINVAL;
> > +
> > +	if (!(file_in->f_mode & FMODE_READ) ||
> > +	    !(file_out->f_mode & FMODE_WRITE))
> > +		return -EBADF;
> > +
> > +	if (len == 0)
> > +		return 0;
> > +
> > +	file_start_write(file_out);
> > +
> > +	/*
> > +	 * skip the verification of the range of data. it will be done
> > +	 * in do_splice_direct
> > +	 */
> > +	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> > +			       len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
> 
> vfs_copy_file_range already does this type of fallback, so this is dead code.
Okay.

> 
> > +#define XATTR_NAME_STREAM_LEN		(sizeof(XATTR_NAME_STREAM) - 1)
> > +
> > +enum {
> > +	XATTR_DOSINFO_ATTRIB		= 0x00000001,
> > +	XATTR_DOSINFO_EA_SIZE		= 0x00000002,
> > +	XATTR_DOSINFO_SIZE		= 0x00000004,
> > +	XATTR_DOSINFO_ALLOC_SIZE	= 0x00000008,
> > +	XATTR_DOSINFO_CREATE_TIME	= 0x00000010,
> > +	XATTR_DOSINFO_CHANGE_TIME	= 0x00000020,
> > +	XATTR_DOSINFO_ITIME		= 0x00000040
> > +};
> > +
> > +struct xattr_dos_attrib {
> > +	__u16	version;
> > +	__u32	flags;
> > +	__u32	attr;
> > +	__u32	ea_size;
> > +	__u64	size;
> > +	__u64	alloc_size;
> > +	__u64	create_time;
> > +	__u64	change_time;
> > +	__u64	itime;
> > +};
> 
> These looks like on-disk structures.  Any chance you could re-order the headers so that things like
> on-disk, on the wire and netlink uapi structures all have a dedicated and well documented header for
> themselves?
Okay.

> 
> > +	read_lock(&ci->m_lock);
> > +	list_for_each(cur, &ci->m_fp_list) {
> > +		lfp = list_entry(cur, struct ksmbd_file, node);
> 
> Please use list_for_each_entry.  There are very few places left where using list_for_each makes sense.
Okay.

> 
> > +		if (inode == FP_INODE(lfp)) {
> > +			atomic_dec(&ci->m_count);
> > +			read_unlock(&ci->m_lock);
> > +			return lfp;
> > +		}
> > +	}
> > +	atomic_dec(&ci->m_count);
> > +	read_unlock(&ci->m_lock);
> 
> So a successful find increments m_count, but a miss decreases it?
> Isn't this going to create an underflow?
m_count is increased from ksmbd_inode_lookup_by_vfsinode().
So m_count should be decreased regardless of finding it.

> 
> > +	if (!fp->f_ci) {
> > +		ksmbd_free_file_struct(fp);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	ret = __open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
> > +	if (ret) {
> > +		ksmbd_inode_put(fp->f_ci);
> > +		ksmbd_free_file_struct(fp);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	atomic_inc(&work->conn->stats.open_files_count);
> > +	return fp;
> 
> Please use goto based unwinding instead of duplicating the resoure cleanup.
Okay.
> 
> > +static bool tree_conn_fd_check(struct ksmbd_tree_connect *tcon,
> > +struct ksmbd_file *fp)
> 
> Overly long line.
Recently, checkpatch.pl has been changed to allow up to 100 character.
You mean cut it to 80 character if possible?
> 
> > +{
> > +	return fp->tcon != tcon;
> > +}
> > +
> > +static bool session_fd_check(struct ksmbd_tree_connect *tcon, struct
> > +ksmbd_file *fp)
> 
> Same.
Okay.

