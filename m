Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B0D558A56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 22:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiFWUsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 16:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiFWUsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:48:41 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F76A4D628
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 13:48:40 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h15-20020a9d600f000000b0060c02d737ecso404824otj.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=reQ2HvYtI6xRF83J9Es5xByV5D7GFf0S7klhjOiAjMc=;
        b=dvZNfwG4SHZnoFiKYLx2GcW0ehFwjmxcUkKxLjQzxmtr55IkCCIFM4GmcPFryAro2e
         VJyaYO3PciQK69zAiFYyELQ9R8qHjYWxKHm35JFz+npiI7DLnaoBT3o9NUjbAuVhlDy2
         FBSmkK8euYt3R+g7U4xhVGRuJcK/DSjv9m3Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=reQ2HvYtI6xRF83J9Es5xByV5D7GFf0S7klhjOiAjMc=;
        b=Z4ya+nASYi7kiAub2X1gdkrPkQPw34e3O6hjo9gsJbtVuhfZuhKgq2TGFsc+iFuG/T
         DfDc/nA9Qo+pOys9aN7nL244OHVNr+PhRvBdXK7VWGybpZkwKbLs5rvXA1/wqms6ZBsK
         YXQW1YMsMiyKwMvt7hT+UyxcGcN3Ls/GwjczW8OWDWZG2ycVhTSrOCbCrGlsOpiU5yBc
         uW+iVcBxJ4bJ5fjE79bVUOaxWOjgN97RSsOD3OX9qsatrZ7oV84uTgiDQBzrZYhz+MNB
         oYvfqXtz2AWF/CQlv7KVEbxs6AGj5OHm/LueC9s7KD7ehjTEin3oIhJy50bUupbe/n8e
         PjaA==
X-Gm-Message-State: AJIora+Lk/d2WTa+jabz8PjNAGuEYAUnWxBx/pwNzVP5RVeIFKRqK16i
        /Jpl8qaIo/PBr6jx7UQfhnqKJA==
X-Google-Smtp-Source: AGRyM1vDZzS9tzC9RRo5Om+Rnyxzo8UbOujmWUviMyNqfteo5lHLJDn2ss243NcBjDIV4gW0LPolRQ==
X-Received: by 2002:a05:6830:310b:b0:60c:66c8:3776 with SMTP id b11-20020a056830310b00b0060c66c83776mr4700172ots.335.1656017319818;
        Thu, 23 Jun 2022 13:48:39 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:9794:3c64:a9f9:ef76])
        by smtp.gmail.com with ESMTPSA id m8-20020a4aab88000000b0041ea640396csm180322oon.41.2022.06.23.13.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 13:48:39 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:48:38 -0500
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 8/8] attr: port attribute changes to new types
Message-ID: <YrTRpsZuOnjFUObl@do-x1extreme>
References: <20220621141454.2914719-1-brauner@kernel.org>
 <20220621141454.2914719-9-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621141454.2914719-9-brauner@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 21, 2022 at 04:14:54PM +0200, Christian Brauner wrote:
> diff --git a/fs/attr.c b/fs/attr.c
> index 88e2ca30d42e..22e310dd483f 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -31,15 +31,15 @@
>   * performed on the raw inode simply passs init_user_ns.
>   */
>  static bool chown_ok(struct user_namespace *mnt_userns,
> -		     const struct inode *inode,
> -		     kuid_t uid)
> +		     const struct inode *inode, vfsuid_t ia_vfsuid)
>  {
> -	kuid_t kuid = i_uid_into_mnt(mnt_userns, inode);
> -	if (uid_eq(current_fsuid(), kuid) && uid_eq(uid, inode->i_uid))
> +	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
> +	if (kuid_eq_vfsuid(current_fsuid(), vfsuid) &&
> +	    vfsuid_eq(ia_vfsuid, vfsuid))
>  		return true;
>  	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_CHOWN))
>  		return true;
> -	if (uid_eq(kuid, INVALID_UID) &&
> +	if (vfsuid_eq(vfsuid, INVALID_VFSUID) &&

If you use my suggestion that comparison to invalid ids should always be
false, this check will need to change to !vfsuid_valid(vfsuid). I'd
argue that this makes the code clearer regardless.

>  	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
>  		return true;
>  	return false;
> @@ -58,21 +58,19 @@ static bool chown_ok(struct user_namespace *mnt_userns,
>   * performed on the raw inode simply passs init_user_ns.
>   */
>  static bool chgrp_ok(struct user_namespace *mnt_userns,
> -		     const struct inode *inode, kgid_t gid)
> +		     const struct inode *inode, vfsgid_t ia_vfsgid)
>  {
> -	kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
> -	if (uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode))) {
> -		kgid_t mapped_gid;
> -
> -		if (gid_eq(gid, inode->i_gid))
> +	vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
> +	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
> +	if (kuid_eq_vfsuid(current_fsuid(), vfsuid)) {
> +		if (vfsgid_eq(ia_vfsgid, vfsgid))
>  			return true;
> -		mapped_gid = mapped_kgid_fs(mnt_userns, i_user_ns(inode), gid);
> -		if (in_group_p(mapped_gid))
> +		if (vfsgid_in_group_p(ia_vfsgid))
>  			return true;
>  	}
>  	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_CHOWN))
>  		return true;
> -	if (gid_eq(kgid, INVALID_GID) &&
> +	if (vfsgid_eq(ia_vfsgid, INVALID_VFSGID) &&

Likewise here.
