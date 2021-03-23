Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69CA3453A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 01:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCWAMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 20:12:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:24481 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhCWAMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:12:20 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210323001218epoutp034ac9c27f748d8d312879abb1fd94ea6c~u0Etp5oNe2676826768epoutp033
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 00:12:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210323001218epoutp034ac9c27f748d8d312879abb1fd94ea6c~u0Etp5oNe2676826768epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616458338;
        bh=uP47+MAZInBagtKyLFw181heQ369em/Nzhd92xvvz9U=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=beNP1Omd4FmDAWLbfWjpcTx3l8YZV7VkIbxtKe3cZrhp9sawdRHupkQfd16RHJSpc
         Ve3e5XJTygihIg/l4OdQfGR2IQ2vKXq4O7+TlJMfyIvaUQsYalwZlA9QqgTcUIt3Ql
         pLhw8RLlFRIkRNbt1y1a3KQt7HbzM1pXu64Lw8KY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210323001217epcas1p3c45c6d17e75c53afbf599ec76593cc04~u0EtF3VBR0148201482epcas1p3b;
        Tue, 23 Mar 2021 00:12:17 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4F4BdF075Vz4x9Q5; Tue, 23 Mar
        2021 00:12:17 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.ED.10347.06239506; Tue, 23 Mar 2021 09:12:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210323001216epcas1p1e3f31c9ae427cb9beab59af3b4fc79ea~u0EroNvP11469614696epcas1p1w;
        Tue, 23 Mar 2021 00:12:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210323001216epsmtrp2b1eb7f4357254bf9a3254a850857c8a4~u0ErnFcYs2193521935epsmtrp2T;
        Tue, 23 Mar 2021 00:12:16 +0000 (GMT)
X-AuditID: b6c32a39-15dff7000002286b-ee-60593260b1e2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.8F.08745.06239506; Tue, 23 Mar 2021 09:12:16 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210323001216epsmtip217f211028a5629cc2745f4c5724f485f~u0ErTahbi1338313383epsmtip2K;
        Tue, 23 Mar 2021 00:12:16 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Al Viro'" <viro@zeniv.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>,
        <linux-cifsd-devel@lists.sourceforge.net>, <smfrench@gmail.com>,
        <senozhatsky@chromium.org>, <hyc.lee@gmail.com>, <hch@lst.de>,
        <hch@infradead.org>, <ronniesahlberg@gmail.com>,
        <aurelien.aptel@gmail.com>, <aaptel@suse.com>,
        <sandeen@sandeen.net>, <dan.carpenter@oracle.com>,
        <colin.king@canonical.com>, <rdunlap@infradead.org>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steve French'" <stfrench@microsoft.com>
In-Reply-To: <YFg/W4q9PHwTAJtZ@zeniv-ca.linux.org.uk>
Subject: RE: [PATCH 3/5] cifsd: add file operations
Date:   Tue, 23 Mar 2021 09:12:16 +0900
Message-ID: <00ad01d71f79$2e9883d0$8bc98b70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGKnGOaYF8FWW41Vo1OapoCvoUV0QMvkMmsAV/TykYDBijVbqrtAR+g
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTVxjHc+69vS1kjEth7lgWh1choRvQUosHBs5FQ64MDcZtbu5D29Gb
        llDappcahiwpRBxjAxG3OQpEhWlRAiiCQoGRAAtoSRg6p5AJQ2BDHa91I8jbWu6W8e33nPN/
        Xv7nRYSLn5MSUZoxk7UYNQaa9CVudofLItTRH6llnYsI5U67CNT7bFWIlmuLSPRs7RyBXCVV
        GLpS+yOGfhmdFaKpdSeOltYXAWrvuE2ge84KEk3/6tEVFS8IUP7PUtR2vYpEde5xIfpzqptE
        w2fOk2hgtVewN5Cx24pIptw2SDCt9kdC5kaNlGm74MaYtiEbyeS3rAqZ+clhgmmqHsOYhqb7
        BONu3MY0TkxjKS8dM8TrWY2WtYSwxlSTNs2oS6DfPaLap1LGyOQR8li0mw4xajLYBHp/ckpE
        YprB45EOOa4xWD1LKRqOo6P2xFtM1kw2RG/iMhNo1qw1mOUycySnyeCsRl1kqikjTi6TRSs9
        SrVBX1ndipsd4VkFEyOkDbzYVghEIkjtgmdX6ELgKxJTLQDmduYL+GABwDnbd0Qh8PEEbgCd
        w3Fe9iYsNLYQvMgJYFNXP+CDJwCu3BnDvSqSioBrK52kl4OocLheWYJ7RThVRsCp70cF3g0f
        SgkLnMtCLwdSCpi75MC8TFChsO6iY6OQHxUL74/YAc8B8HbZxMZIOPU6vDVdgfMjhcClycsC
        vlkinOrPE/CaIFj+xamNxpBy+MCeSzWAT9gPBwtuCHgOhE97m4Q8S6B7poPkD+YEnO/8t34B
        gFOLCTwr4FDDNYFXgnuMNTij+OXtsHW5EvBtX4Yzf30l4Kv4wYJTYl4SCovvdmM8B8PCz+eE
        JYC2bzJm32TMvsmA/f9mFwBxFWxhzVyGjuXkZuXmu24EG89fGtsCzk3PRXYBTAS6ABThdJDf
        yaMfqsV+Ws2n2azFpLJYDSzXBZSeoz6DS15JNXn+jzFTJVdGKxQKtCtmd4xSQb/q94nsN5WY
        0mky2XSWNbOW//IwkY/EhqXv+5Ybq8+ApaZSidWcfTCprirywMPa+o6L/o6brvYfwoRHD9wJ
        4w6dN8XrTpbvPBznb93atLpFWnramnR97dGl02E5gw/65tta29nhxK2Ec8+OipwEPO1jdnln
        ku0NMZkd9VaJg7z74D01kD5erOlOfzPmVm5onnaA+/J9V06FrmbQ9dphWUny+uz42GRA8cr8
        C8nz1D9GH/7d02eaPVuk3ivV+9YT4rKR5NXCax/05R16LH1SvaOTi9VF9FPbK3VYM+d+++tj
        cvFPBxm2diDakTpe1Jz+tE91osdKZAdcbS/t6gs9zmbJZt+53OuqjxwK1v8+s3QP9/8mOO2z
        rOYKmuD0GrkUt3CafwABX29dhwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7bCSvG6CUWSCwZk5fBaNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2i7d3gOp6
        +z6xWrRe0bLYvXERm8Xaz4/ZLd68OMxmcWvifDaL83+PszoIe8xq6GXzmN1wkcVj56y77B6b
        V2h57F7wmclj980GNo/WHX/ZPT4+vcXisWXxQyaP9Vuusnh83iTnsenJW6YAnigum5TUnMyy
        1CJ9uwSujLmLdzIXLNes6Hhyj62B8ZdcFyMnh4SAicSnTTtYuhi5OIQEdjBK/O69wgKRkJY4
        duIMcxcjB5AtLHH4cDFIWEjgOaPE55ZMEJtNQFfi35/9bCC2iICmxP+5E5hB5jALrGWR2HH4
        CyvE0GeMEhcXvWQHqeIUMJXo2PUbzBYWMJZo/LmcCcRmEVCVWLtwOTOIzStgKXH13ixGCFtQ
        4uTMJywgRzAL6Em0bQQLMwvIS2x/O4cZ4k4FiZ9Pl7FCHOEm8eJMEytEjYjE7M425gmMwrOQ
        TJqFMGkWkkmzkHQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRnAS0tHYw7ln1
        Qe8QIxMH4yFGCQ5mJRHelvCIBCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGan
        phakFsFkmTg4pRqYjje9+qDRWtV0XeCJesQvt0/W93LZH73bv9XlpL/Ikd0Mu41/e0cFst1a
        +VTFTizxtdc7LtPfzV92TfnPt1D+xentyTrBDWcrE3XyzvjUaLc/kg8z250bJhnmlVe4T/kZ
        T9kttznCiT9mFxpYX2hdYFZTZHLRq///xhKGtOWm9d5lJbtTFv9xnPKuO+2hbbTJBh6OvRnz
        tBlnb1nRe6NpS06ai/bG1+WvHlpMmd7q8qQl3FXzKedygav6cVWPFTzeyu1Qrry3rOK90VMN
        v88pUe+zHsk9UNuvxinfcPv4psoy58Oqm55cbL9ZOu387Gs7u1S0c2/tZgjnlks8K1eczlOq
        yDg7Xk1/2aOEE6+UWIozEg21mIuKEwGG9KvccQMAAA==
X-CMS-MailID: 20210323001216epcas1p1e3f31c9ae427cb9beab59af3b4fc79ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
        <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com>
        <20210322051344.1706-4-namjae.jeon@samsung.com>
        <YFg/W4q9PHwTAJtZ@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Mon, Mar 22, 2021 at 02:13:42PM +0900, Namjae Jeon wrote:
> > This adds file operations and buffer pool for cifsd.
> 
> Some random notes:
> 
> > +static void rollback_path_modification(char *filename) {
> > +	if (filename) {
> > +		filename--;
> > +		*filename = '/';
> What an odd way to spell filename[-1] = '/';...
Okay. Will fix.
> 
> > +int ksmbd_vfs_inode_permission(struct dentry *dentry, int acc_mode,
> > +bool delete) {
> 
> > +	if (delete) {
> > +		struct dentry *parent;
> > +
> > +		parent = dget_parent(dentry);
> > +		if (!parent)
> > +			return -EINVAL;
> > +
> > +		if (inode_permission(&init_user_ns, d_inode(parent), MAY_EXEC | MAY_WRITE)) {
> > +			dput(parent);
> > +			return -EACCES;
> > +		}
> > +		dput(parent);
> 
> Who's to guarantee that parent is stable?  IOW, by the time of that
> inode_permission() call dentry might very well not be a child of that thing...
Okay, Will fix.
> 
> > +	parent = dget_parent(dentry);
> > +	if (!parent)
> > +		return 0;
> > +
> > +	if (!inode_permission(&init_user_ns, d_inode(parent), MAY_EXEC | MAY_WRITE))
> > +		*daccess |= FILE_DELETE_LE;
> 
> Ditto.
Okay.
> 
> > +int ksmbd_vfs_mkdir(struct ksmbd_work *work,
> > +		    const char *name,
> > +		    umode_t mode)
> 
> 
> > +	err = vfs_mkdir(&init_user_ns, d_inode(path.dentry), dentry, mode);
> > +	if (!err) {
> > +		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry),
> > +			d_inode(dentry));
> 
> ->mkdir() might very well return success, with dentry left unhashed negative.
> Look at the callers of vfs_mkdir() to see how it should be handled.
Okay, Will fix.
> 
> > +static int check_lock_range(struct file *filp,
> > +			    loff_t start,
> > +			    loff_t end,
> > +			    unsigned char type)
> > +{
> > +	struct file_lock *flock;
> > +	struct file_lock_context *ctx = file_inode(filp)->i_flctx;
> > +	int error = 0;
> > +
> > +	if (!ctx || list_empty_careful(&ctx->flc_posix))
> > +		return 0;
> > +
> > +	spin_lock(&ctx->flc_lock);
> > +	list_for_each_entry(flock, &ctx->flc_posix, fl_list) {
> > +		/* check conflict locks */
> > +		if (flock->fl_end >= start && end >= flock->fl_start) {
> > +			if (flock->fl_type == F_RDLCK) {
> > +				if (type == WRITE) {
> > +					ksmbd_err("not allow write by shared lock\n");
> > +					error = 1;
> > +					goto out;
> > +				}
> > +			} else if (flock->fl_type == F_WRLCK) {
> > +				/* check owner in lock */
> > +				if (flock->fl_file != filp) {
> > +					error = 1;
> > +					ksmbd_err("not allow rw access by exclusive lock from other
> opens\n");
> > +					goto out;
> > +				}
> > +			}
> > +		}
> > +	}
> > +out:
> > +	spin_unlock(&ctx->flc_lock);
> > +	return error;
> > +}
> 
> WTF is that doing in smbd?
This code was added to pass the smb2 lock test of samba's smbtorture.
Will fix it.
> 
> > +	filp = fp->filp;
> > +	inode = d_inode(filp->f_path.dentry);
> 
> That should be file_inode().  Try it on overlayfs, watch it do interesting things...
Okay.
> 
> > +	nbytes = kernel_read(filp, rbuf, count, pos);
> > +	if (nbytes < 0) {
> > +		name = d_path(&filp->f_path, namebuf, sizeof(namebuf));
> > +		if (IS_ERR(name))
> > +			name = "(error)";
> > +		ksmbd_err("smb read failed for (%s), err = %zd\n",
> > +				name, nbytes);
> 
> Do you really want the full pathname here?  For (presumably) spew into syslog?
No, Will fix.
> 
> > +int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name) {
> > +	struct path parent;
> > +	struct dentry *dir, *dentry;
> > +	char *last;
> > +	int err = -ENOENT;
> > +
> > +	last = extract_last_component(name);
> > +	if (!last)
> > +		return -ENOENT;
> 
> Yeccchhh...
I guess I change it err instead of -ENOENT.

> 
> > +	if (ksmbd_override_fsids(work))
> > +		return -ENOMEM;
> > +
> > +	err = kern_path(name, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &parent);
> > +	if (err) {
> > +		ksmbd_debug(VFS, "can't get %s, err %d\n", name, err);
> > +		ksmbd_revert_fsids(work);
> > +		rollback_path_modification(last);
> > +		return err;
> > +	}
> > +
> > +	dir = parent.dentry;
> > +	if (!d_inode(dir))
> > +		goto out;
> 
> Really?  When does that happen?
Will fix.
> 
> > +static int __ksmbd_vfs_rename(struct ksmbd_work *work,
> > +			      struct dentry *src_dent_parent,
> > +			      struct dentry *src_dent,
> > +			      struct dentry *dst_dent_parent,
> > +			      struct dentry *trap_dent,
> > +			      char *dst_name)
> > +{
> > +	struct dentry *dst_dent;
> > +	int err;
> > +
> > +	spin_lock(&src_dent->d_lock);
> > +	list_for_each_entry(dst_dent, &src_dent->d_subdirs, d_child) {
> > +		struct ksmbd_file *child_fp;
> > +
> > +		if (d_really_is_negative(dst_dent))
> > +			continue;
> > +
> > +		child_fp = ksmbd_lookup_fd_inode(d_inode(dst_dent));
> > +		if (child_fp) {
> > +			spin_unlock(&src_dent->d_lock);
> > +			ksmbd_debug(VFS, "Forbid rename, sub file/dir is in use\n");
> > +			return -EACCES;
> > +		}
> > +	}
> > +	spin_unlock(&src_dent->d_lock);
> 
> Hard NAK right there.  That thing has no business poking at that level.
> And I'm pretty certain that it's racy as hell.
Okay. It was same reason(smbtorture test), will fix it also.

Thanks for your review!

