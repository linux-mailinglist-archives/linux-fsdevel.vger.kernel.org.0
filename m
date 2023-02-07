Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7A768DFC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 19:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjBGSSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 13:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjBGSRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:31 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197C283F4;
        Tue,  7 Feb 2023 10:17:11 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id u22so252414ejj.10;
        Tue, 07 Feb 2023 10:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DyS0e8ODQcZLL8R+DhS/GEUd+bmqbIzU17oRZ+uJh00=;
        b=TJXziBFfxz2Pe122lSG1GlRJXaO6If9SEpQ3jGGa5QfGSlXh0Y4CpyIkgMQsmb/pa2
         38bSfPQH959vu+8mxfVLDYWcw6LpAdALD/IJaD4/QCWrw8yqqsJ+IsgCsCpDlGxyy5Al
         AVJf6Ke2E1awRXAHrsRuxGCN9OgtrvxKfuvY4j2asTYJLY8F3dL3A4dh17lJNw+LWiP2
         ZUHrMSDLVWpXcktBH8LVahRFH7QO5ENyRH3wVz+Lc4JxqeMSv4NiUugnRfiNwrndGxqH
         LzAamiB1SqgNqXkuyk8XsjcMP3iAe7nc4GWKY2BY3JDaA88Exmk02gMo4ArDuw0xgNhN
         zilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyS0e8ODQcZLL8R+DhS/GEUd+bmqbIzU17oRZ+uJh00=;
        b=PvbrXHsPVaRHBKdc9XQJzrXuNpG7qm7cOQT/dOC1aQnUPP1AcaCA7MHXN82hamBpH3
         k+TpDkpKV/6PRv1TXk8Mn47gtqIfL2PG9lBg23vjbhDauajSUfDPLqpH/2UCsBJ5/RyO
         y1geSAv3/x8Akb3yHmx6FdvYocnj76oUMT6VRLfpFJsjEPZZ/CL4nPXGs6ktLpe8zMgW
         ToElbx8kqYkTjeiu/2jpBUBOOqS/t9NK6uIwKx37bNESwRLfzStF9+LL20brTud1AikQ
         qslrpC947nh8D/wiwPuprINOkzHjxbLQZhB14aBvPNuVfxe40/KXDugOsCmybBnESDhA
         +4Fw==
X-Gm-Message-State: AO0yUKVz7eGgm7ObBIMFckH1V2p07q7MgtQ4Ad6TAuHN7yU2R7BLeBa3
        FBD48rStExJeaUAqz59bAw==
X-Google-Smtp-Source: AK7set89O6/pkec47ExsoKO7Bz6P9RPCw+WjDLDwV4lI8CenZjv3bQGcMO33ky8qBGUVqk74AY/j3w==
X-Received: by 2002:a17:906:d0c4:b0:891:a330:c890 with SMTP id bq4-20020a170906d0c400b00891a330c890mr4722632ejb.0.1675793826660;
        Tue, 07 Feb 2023 10:17:06 -0800 (PST)
Received: from p183 ([46.53.250.18])
        by smtp.gmail.com with ESMTPSA id d20-20020a17090694d400b0088e682e3a4csm7115929ejy.185.2023.02.07.10.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:17:06 -0800 (PST)
Date:   Tue, 7 Feb 2023 21:17:04 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Chao Yu <chao@kernel.org>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] proc: remove mark_inode_dirty() in .setattr()
Message-ID: <Y+KVoI/GVaoEFQxa@p183>
References: <20230131150840.34726-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230131150840.34726-1-chao@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 11:08:40PM +0800, Chao Yu wrote:
> procfs' .setattr() has updated i_uid, i_gid and i_mode into proc
> dirent, we don't need to call mark_inode_dirty() for delayed
> update, remove it.

> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -699,7 +699,6 @@ int proc_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  		return error;
>  
>  	setattr_copy(&init_user_ns, inode, attr);
> -	mark_inode_dirty(inode);

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
