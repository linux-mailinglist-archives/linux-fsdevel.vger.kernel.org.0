Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D9342AC42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 20:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhJLSoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 14:44:24 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:32984
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235060AbhJLSoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634064121; bh=ryILQDN+Vdpk9e1cy0ZPjy7bMRa061Rif+z+2kjlcro=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=RRTFVz30LskRQBy38EdWNgrZiqWEfYYUIBPGGCrD7PlMI94ZOnSgp+v0ZUWQhOnKvN7yhQpPkQc7OdW+kfLFB8EYHh4GnmdT6OgOAVTLSvKibMQ0AyjDCTooSr1K0nj6Fu+Ln0sKuu5D3B1RIDuYwc1VZ2WCdUkaQ06zETS/hZhrVofVDI0TDkiOXyKITNMvT1jdRFhHPt6ZxRUNSr7gnwGruLGiohP/lfQchtElJ+IVkyOueBF3TdwSXZ1mPp1wTOB71akjBERbM2Sr3s1GiSi1xlAhoYCren7xsd5HjJhbWXO3aj3rrxslTTYLWo2r/T6lVG4WqFXvPc3eYmdeKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634064121; bh=sF9fZ0HtfDRmfoyiB+vobfx7iGWm+WNp7PdIIlsZpTz=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=Oqk5UIoOd7BUa9hW6yZLvhJKAbZgy9ostznoErGSskOc/qsSvmsUwyT83+dC+AhJsh9CTxvcLb/EwpgHAJqRbKMudGSL3pQxN2e7+TpmHi636d4HtQW6REm60m3iYScmPrcPdpOazBJGib/P0RxDzZAD5wO61SHknACJLgF4js79otNI0T1AqBUgrWRQ9wSEBQpK5Qtg414jYtcqqVkOhzE4/c8RQQFIy5Ei4wnBlpC5VjCmI7cnYVSwsbzEA4xhrx/kmwt4HaBxPXmQeexLtm0MBprPKL02tUuReVLKTQkarVyYzuORS4pD5oLTOxxonjmx9i/Pb3CdrSJIFWKEqQ==
X-YMail-OSG: ES7ZVskVM1kFW37ttn.dhv.IDjKaTwTlMoQxD1gWdc3ov.sK8eoOPUiyXGQC0Wn
 YlEqgNmx5TZ_Ne8y.ZAsN9H9JtIIOR4eBe3k2LLmguPtbvMLY2OHh55JzyDCJCiv0RwcwEbPpJsQ
 Yp5k_rCH9.Z_IbyE.8K.Sz0rjCTz3MjWNp4VaptlwM0enmDccLc0nUrS0dQTRNWrIW4LcNcdLkU1
 v_I.3XsoCEQBLIeDzNyEhbuTze1gFBY_C68rQdfWFRnj.1XBLxErcFx.q5nLBnvaqibkBUW0517H
 ybUZ.dU5S7yVyKoNwD7I5LpF6_UOaDyhsVjKzfD27d9WFJ8VfLinN1jyQnS9qyc7lendOWmGgdE1
 eBYLjsoj23T6vSjHugurIr0FQ0g13vAxVEBhW_shjPpZ7a4E_u0NQVyfPRQRyCfHLU4NyJLL5upK
 guUbqFejsqHTOEQKaXMcOGKraebC1MACXi3Jcwvt8EzVR0eaK4ed.I.jb6H.CI2xWRP89cS6fWKu
 a3vSLnu7cBZU862o27qwzCRw0C8jk84C99_eCkYQnDCCKd0AuZKEbMiQm4Ke9hJKjuuPDKU7yzPt
 1e9oRks0QpL8OK0_SRvuRH9xPKDZ2xM_MkxbZIocvTGr_kNC.oMSbXg6KStA3xZZls64JP5NuS2n
 CgGw8.c345pq5aJPic7BrSfV5hCLn3AiyP5gJBknP7Eawm2Ho0gMJxf20apHqCO4jc24Vry2yX2G
 saivGLdnG3b1GD.Wqmg5wMQaNo.UUM2VcZ8fRijOPeBTImLrF7Yn_Tm7Berk_3ymZIws0dFFrIrS
 jHGKg0Z5WKc6sKmE4fdscZN4ne4qqwazAQy8YchifdHyDLkqH.M7q3vYMqJ.9kcEO2X46Io5Sa8M
 n0DHllW9MJyFh15XkMjUId9VDsPHF0di8An8XiLi1Q4GjUC8lwMRlEvTuc7K80FkHUA9o388ADyP
 DNbS3G4R770d_e0.Zq.88PcGl_Yp.6v58fUywWuap1sQqeJ6e4G3yqJKF1Gt6CF95ZrHwGfJkpSH
 EiG6dscreGUELzU1Fprv9C0lWvWraPEq9JX..D7ZC34VSF40Bst9Qr7gUnYtJ2hDJTbjscbicane
 .ff09PLxi3ni..0kdaRGdDnclErP7NCbrGE9cAnvJ92vFeaUHlods2_d92Ua6lcKUbxGFgKPlE0K
 _Y9J8b0yUyyfOMvSEMdRsJGJ6GDLknGYWLOHq6woDTga979.jInoDKZPrAdC71cOKKBEgi3k0jEf
 t4NN8xKXovSu_A1i8uobNKFxC3SFEGoh_fD05CIyV4yhSxO6WQyBZ1SvRSEHTegKAZ56KfwK9WRm
 FaAX_mmHg88QI5yITCgyAC_YlDvCfTjGXMBVoITBfMMB3.09qZgu_5JLgl1Q3b3IMGC1zJKq4HN5
 Q3O1wIy.m.Qxep3mNB2N6ZBQ7pBH2i3cFz8W_54R7jjJYJEShWZyg8iEf94HnW74KB04J.FwfBz2
 WXrk1..zb.VdR_xJIoNvOaq4t0fYgp_zSefYtKuyeaftOqW2NKwWpFOyG2_.EJEZURNCT56mdl5h
 PHKTbzQI6kvhShG7xRbBWG.zdq5nS7HFp37p2KXNiPZXFSchhojH4f8IvWMdknniYYWQKfAPP7yX
 pdI6RZZzcMC_XfM_K2ILMEei7Mq.hPI6B2PS6DWfDE0JnZONEn0Lm4fwlSS8U9EhDns73k.JtDKF
 qvAto08YqNjDWSTSAK6LB5pt1yuyrPuokzUWSZ8Al1YS3L2AmDQChuFlAHSgHhMi7afPJ13aA6c7
 dbyW1Oc6hmOZnOuYxdR1MmmTBulg5xM8bUxx_SJYh5AgJTKrToB11pjrhe9lo2ewTuSHjbNUCXli
 cbtRAARpgmoYpjIuOZJ8YWhM3o1pJLZhqRKXG3QF396O9kU7HjuUR7ZroCaFwAtEckro5hPrdJvO
 BtoznwrwsN..uaQAhfs9Tv_xSvQadczV_GQFl6ZnBHpwxt3IkmUs8SWssjBeTVWAeBor_7Kc7gOx
 8wn_KNNTF4HPtPqWchsZ7vAdjgenU5J2DYORrNN.3C44PHQcgmZzzH5Xu.KVmj15YuGAH1kTSmLA
 1lvl8KZqr5cpMLP5d9IisxqwWXG7J5crF24IL39Ho3qwvUN.li__rBQdR4NkElO.wVsIeXFX0DBE
 WHG2VpLUwuGx9Z00M4PIH9GIcYFWN9pBs0IC7XANY9uAtmq2KkRQtUJ3LtPy0cg18y6CmLpcByul
 w5cZaAc8JxwYwewIl.CQnD2_G0XiaOins9_5UGdO8bfPKWDwzBzgabogku7_TQQ0RgzTMfzkUMWB
 ZKLA-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Oct 2021 18:42:01 +0000
Received: by kubenode534.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ec08be640327267e656d8d682af50958;
          Tue, 12 Oct 2021 18:41:57 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] fuse: Send security context of inode on file
 creation
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, miklos@szeredi.hu,
        virtio-fs@redhat.com, chirantan@chromium.org,
        stephen.smalley.work@gmail.com, dwalsh@redhat.com,
        omosnace@redhat.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20211012180624.447474-1-vgoyal@redhat.com>
 <20211012180624.447474-3-vgoyal@redhat.com>
 <3ee8ffdb-ab64-4b7d-1030-c370a1c0e3a8@schaufler-ca.com>
 <YWXVJ1bss4Vwa3la@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <eb333e63-dc1a-b00b-12a3-10a6bc2b41bc@schaufler-ca.com>
Date:   Tue, 12 Oct 2021 11:41:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YWXVJ1bss4Vwa3la@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.19116 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/12/2021 11:34 AM, Vivek Goyal wrote:
> On Tue, Oct 12, 2021 at 11:24:23AM -0700, Casey Schaufler wrote:
>> On 10/12/2021 11:06 AM, Vivek Goyal wrote:
>>> When a new inode is created, send its security context to server along
>>> with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_SYMLINK).
>>> This gives server an opportunity to create new file and set security
>>> context (possibly atomically). In all the configurations it might not
>>> be possible to set context atomically.
>>>
>>> Like nfs and ceph, use security_dentry_init_security() to dermine security
>>> context of inode and send it with create, mkdir, mknod, and symlink requests.
>>>
>>> Following is the information sent to server.
>>>
>>> - struct fuse_secctxs.
>>>   This contains total number of security contexts being sent.
>>>
>>> - struct fuse_secctx.
>>>   This contains total size of security context which follows this structure.
>>>   There is one fuse_secctx instance per security context.
>>>
>>> - xattr name string.
>>>   This string represents name of xattr which should be used while setting
>>>   security context. As of now it is hardcoded to "security.selinux".
>> Where is the name hardcoded? I looks as if you're getting the attribute
>> name along with the value from security_dentry_init_security().
> Sorry, I copied pasted this description from V1 where I was hardcoding
> the name to "security.selinux".

That's what I suspected. Thanks.

>  But V2 got rid of that hardcoding and
> that's why this patch series is dependent on the other patch which
> modifies security_dentry_init_security() signature.
>
> https://lore.kernel.org/linux-fsdevel/YWWMO%2FZDrvDZ5X4c@redhat.com/
>
> Thanks
> Vivek
>
>>> - security context.
>>>   This is the actual security context whose size is specified in fuse_secctx
>>>   struct.
>>>
>>> This patch is modified version of patch from
>>> Chirantan Ekbote <chirantan@chromium.org>
>>>
>>> v2:
>>> - Added "fuse_secctxs" structure where one can specify how many security
>>>   contexts are being sent. This can be useful down the line if we
>>>   have more than one security contexts being set.
>>>
>>> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>>> ---
>>>  fs/fuse/dir.c             | 115 ++++++++++++++++++++++++++++++++++++--
>>>  fs/fuse/fuse_i.h          |   3 +
>>>  fs/fuse/inode.c           |   4 +-
>>>  include/uapi/linux/fuse.h |  20 +++++++
>>>  4 files changed, 136 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>>> index d9b977c0f38d..ce62593a61f9 100644
>>> --- a/fs/fuse/dir.c
>>> +++ b/fs/fuse/dir.c
>>> @@ -17,6 +17,9 @@
>>>  #include <linux/xattr.h>
>>>  #include <linux/iversion.h>
>>>  #include <linux/posix_acl.h>
>>> +#include <linux/security.h>
>>> +#include <linux/types.h>
>>> +#include <linux/kernel.h>
>>>  
>>>  static void fuse_advise_use_readdirplus(struct inode *dir)
>>>  {
>>> @@ -456,6 +459,66 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
>>>  	return ERR_PTR(err);
>>>  }
>>>  
>>> +static int get_security_context(struct dentry *entry, umode_t mode,
>>> +				void **security_ctx, u32 *security_ctxlen)
>>> +{
>>> +	struct fuse_secctx *fsecctx;
>>> +	struct fuse_secctxs *fsecctxs;
>>> +	void *ctx, *full_ctx;
>>> +	u32 ctxlen, full_ctxlen;
>>> +	int err = 0;
>>> +	const char *name;
>>> +
>>> +	err = security_dentry_init_security(entry, mode, &entry->d_name,
>>> +					    &name, &ctx, &ctxlen);
>>> +	if (err) {
>>> +		if (err != -EOPNOTSUPP)
>>> +			goto out_err;
>>> +		/* No LSM is supporting this security hook. Ignore error */
>>> +		err = 0;
>>> +		ctxlen = 0;
>>> +	}
>>> +
>>> +	if (ctxlen > 0) {
>>> +		void *ptr;
>>> +
>>> +		full_ctxlen = sizeof(*fsecctxs) + sizeof(*fsecctx) +
>>> +			      strlen(name) + ctxlen + 1;
>>> +		full_ctx = kzalloc(full_ctxlen, GFP_KERNEL);
>>> +		if (!full_ctx) {
>>> +			err = -ENOMEM;
>>> +			kfree(ctx);
>>> +			goto out_err;
>>> +		}
>>> +
>>> +		ptr = full_ctx;
>>> +		fsecctxs = (struct fuse_secctxs*) ptr;
>>> +		fsecctxs->nr_secctx = 1;
>>> +		ptr += sizeof(*fsecctxs);
>>> +
>>> +		fsecctx = (struct fuse_secctx*) ptr;
>>> +		fsecctx->size = ctxlen;
>>> +		ptr += sizeof(*fsecctx);
>>> +
>>> +		strcpy(ptr, name);
>>> +		ptr += strlen(name) + 1;
>>> +		memcpy(ptr, ctx, ctxlen);
>>> +		kfree(ctx);
>>> +	} else {
>>> +		full_ctxlen = sizeof(*fsecctxs);
>>> +		full_ctx = kzalloc(full_ctxlen, GFP_KERNEL);
>>> +		if (!full_ctx) {
>>> +			err = -ENOMEM;
>>> +			goto out_err;
>>> +		}
>>> +	}
>>> +
>>> +	*security_ctxlen = full_ctxlen;
>>> +	*security_ctx = full_ctx;
>>> +out_err:
>>> +	return err;
>>> +}
>>> +
>>>  /*
>>>   * Atomic create+open operation
>>>   *
>>> @@ -476,6 +539,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>>>  	struct fuse_entry_out outentry;
>>>  	struct fuse_inode *fi;
>>>  	struct fuse_file *ff;
>>> +	void *security_ctx = NULL;
>>> +	u32 security_ctxlen;
>>>  
>>>  	/* Userspace expects S_IFREG in create mode */
>>>  	BUG_ON((mode & S_IFMT) != S_IFREG);
>>> @@ -517,6 +582,18 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>>>  	args.out_args[0].value = &outentry;
>>>  	args.out_args[1].size = sizeof(outopen);
>>>  	args.out_args[1].value = &outopen;
>>> +
>>> +	if (fm->fc->init_security) {
>>> +		err = get_security_context(entry, mode, &security_ctx,
>>> +					   &security_ctxlen);
>>> +		if (err)
>>> +			goto out_put_forget_req;
>>> +
>>> +		args.in_numargs = 3;
>>> +		args.in_args[2].size = security_ctxlen;
>>> +		args.in_args[2].value = security_ctx;
>>> +	}
>>> +
>>>  	err = fuse_simple_request(fm, &args);
>>>  	if (err)
>>>  		goto out_free_ff;
>>> @@ -554,6 +631,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>>>  
>>>  out_free_ff:
>>>  	fuse_file_free(ff);
>>> +	kfree(security_ctx);
>>>  out_put_forget_req:
>>>  	kfree(forget);
>>>  out_err:
>>> @@ -613,13 +691,15 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>>>   */
>>>  static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
>>>  			    struct inode *dir, struct dentry *entry,
>>> -			    umode_t mode)
>>> +			    umode_t mode, bool init_security)
>>>  {
>>>  	struct fuse_entry_out outarg;
>>>  	struct inode *inode;
>>>  	struct dentry *d;
>>>  	int err;
>>>  	struct fuse_forget_link *forget;
>>> +	void *security_ctx = NULL;
>>> +	u32 security_ctxlen = 0;
>>>  
>>>  	if (fuse_is_bad(dir))
>>>  		return -EIO;
>>> @@ -633,7 +713,29 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
>>>  	args->out_numargs = 1;
>>>  	args->out_args[0].size = sizeof(outarg);
>>>  	args->out_args[0].value = &outarg;
>>> +
>>> +	if (init_security) {
>>> +		unsigned short idx = args->in_numargs;
>>> +
>>> +		if ((size_t)idx >= ARRAY_SIZE(args->in_args)) {
>>> +			err = -ENOMEM;
>>> +			goto out_put_forget_req;
>>> +		}
>>> +
>>> +		err = get_security_context(entry, mode, &security_ctx,
>>> +					   &security_ctxlen);
>>> +		if (err)
>>> +			goto out_put_forget_req;
>>> +
>>> +		if (security_ctxlen > 0) {
>>> +			args->in_args[idx].size = security_ctxlen;
>>> +			args->in_args[idx].value = security_ctx;
>>> +			args->in_numargs++;
>>> +		}
>>> +	}
>>> +
>>>  	err = fuse_simple_request(fm, args);
>>> +	kfree(security_ctx);
>>>  	if (err)
>>>  		goto out_put_forget_req;
>>>  
>>> @@ -691,7 +793,7 @@ static int fuse_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>>>  	args.in_args[0].value = &inarg;
>>>  	args.in_args[1].size = entry->d_name.len + 1;
>>>  	args.in_args[1].value = entry->d_name.name;
>>> -	return create_new_entry(fm, &args, dir, entry, mode);
>>> +	return create_new_entry(fm, &args, dir, entry, mode, fm->fc->init_security);
>>>  }
>>>  
>>>  static int fuse_create(struct user_namespace *mnt_userns, struct inode *dir,
>>> @@ -719,7 +821,8 @@ static int fuse_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>>>  	args.in_args[0].value = &inarg;
>>>  	args.in_args[1].size = entry->d_name.len + 1;
>>>  	args.in_args[1].value = entry->d_name.name;
>>> -	return create_new_entry(fm, &args, dir, entry, S_IFDIR);
>>> +	return create_new_entry(fm, &args, dir, entry, S_IFDIR,
>>> +				fm->fc->init_security);
>>>  }
>>>  
>>>  static int fuse_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>>> @@ -735,7 +838,8 @@ static int fuse_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>>>  	args.in_args[0].value = entry->d_name.name;
>>>  	args.in_args[1].size = len;
>>>  	args.in_args[1].value = link;
>>> -	return create_new_entry(fm, &args, dir, entry, S_IFLNK);
>>> +	return create_new_entry(fm, &args, dir, entry, S_IFLNK,
>>> +				fm->fc->init_security);
>>>  }
>>>  
>>>  void fuse_update_ctime(struct inode *inode)
>>> @@ -915,7 +1019,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
>>>  	args.in_args[0].value = &inarg;
>>>  	args.in_args[1].size = newent->d_name.len + 1;
>>>  	args.in_args[1].value = newent->d_name.name;
>>> -	err = create_new_entry(fm, &args, newdir, newent, inode->i_mode);
>>> +	err = create_new_entry(fm, &args, newdir, newent, inode->i_mode,
>>> +			       false);
>>>  	/* Contrary to "normal" filesystems it can happen that link
>>>  	   makes two "logical" inodes point to the same "physical"
>>>  	   inode.  We invalidate the attributes of the old one, so it
>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>> index 319596df5dc6..885f34f9967f 100644
>>> --- a/fs/fuse/fuse_i.h
>>> +++ b/fs/fuse/fuse_i.h
>>> @@ -765,6 +765,9 @@ struct fuse_conn {
>>>  	/* Propagate syncfs() to server */
>>>  	unsigned int sync_fs:1;
>>>  
>>> +	/* Initialize security xattrs when creating a new inode */
>>> +	unsigned int init_security:1;
>>> +
>>>  	/** The number of requests waiting for completion */
>>>  	atomic_t num_waiting;
>>>  
>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index 36cd03114b6d..343bc9cfbd92 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -1152,6 +1152,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>>>  			}
>>>  			if (arg->flags & FUSE_SETXATTR_EXT)
>>>  				fc->setxattr_ext = 1;
>>> +			if (arg->flags & FUSE_SECURITY_CTX)
>>> +				fc->init_security = 1;
>>>  		} else {
>>>  			ra_pages = fc->max_read / PAGE_SIZE;
>>>  			fc->no_lock = 1;
>>> @@ -1195,7 +1197,7 @@ void fuse_send_init(struct fuse_mount *fm)
>>>  		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
>>>  		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
>>>  		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
>>> -		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT;
>>> +		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_SECURITY_CTX;
>>>  #ifdef CONFIG_FUSE_DAX
>>>  	if (fm->fc->dax)
>>>  		ia->in.flags |= FUSE_MAP_ALIGNMENT;
>>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>>> index 2fe54c80051a..b31a0f79fde8 100644
>>> --- a/include/uapi/linux/fuse.h
>>> +++ b/include/uapi/linux/fuse.h
>>> @@ -986,4 +986,24 @@ struct fuse_syncfs_in {
>>>  	uint64_t	padding;
>>>  };
>>>  
>>> +/*
>>> + * For each security context, send fuse_secctx with size of security context
>>> + * fuse_secctx will be followed by security context name and this in turn
>>> + * will be followed by actual context label.
>>> + * fuse_secctx, name, context
>>> + * */
>>> +struct fuse_secctx {
>>> +	uint32_t	size;
>>> +	uint32_t	padding;
>>> +};
>>> +
>>> +/*
>>> + * Contains the information about how many fuse_secctx structures are being
>>> + * sent.
>>> + */
>>> +struct fuse_secctxs {
>>> +	uint32_t	nr_secctx;
>>> +	uint32_t	padding;
>>> +};
>>> +
>>>  #endif /* _LINUX_FUSE_H */
