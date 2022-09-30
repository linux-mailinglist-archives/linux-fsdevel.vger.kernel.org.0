Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EAC5F0D28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiI3OMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiI3OLi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:11:38 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6481A0D19
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 07:11:23 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id m11-20020a4aab8b000000b00476743c0743so2296690oon.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+02lWUnQnVpnIW75GUY8RdFtLVPFU6flJQgBwpnhGBU=;
        b=rt5DQ1gpYyGWOabp0rvarti0MXhPdro0zgBzGjdJTaVn4/FqeqPqFXgSFzQsik2ABd
         9gsm3BPQAiQpVGKpvObwIPzi9rg//WYfatrw+sxudu9uNLCFZHSsH038qSLByxlif17I
         BwL+l7VEMY5C5gkCZxAU6RyD+YxD+bW/RNMAxit/EbqYk+ZMjyaNb74drfob5aOGywia
         xR3NyIekUQE6WaeyzlsKxuulWSZW76djBTE+3habFDW2TsMc1jnMluI+MSpnlIVE5Fsb
         uYEpJQJkg1pO0wSBzS01JkOGnsjjM4FORQilbPczPZC8TRFrh2om7f4JPILCTsaDuNXm
         dxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+02lWUnQnVpnIW75GUY8RdFtLVPFU6flJQgBwpnhGBU=;
        b=p3/3Wfj5A8wGzD2x3E1ojEnRt6XFAORQMmtNXtQQCUiJtVjnagpW2CU6oxzhEvEIHt
         3MeXVOTH7TOystukob95ptMFlCAaQOeq/V6grT7ADz3QHN0K6PwmBqFisqmrNQB0Y5Kd
         ptPs+H1aqKOJT/jya59nQtbiDVq5CDqG06vOeP8RZduzEgmNJle/rFiQv0ULucLfGkuE
         Q4l+/uJGR92zgquEN5bSUXzvpRgrPeecLxFYizP9MOWeynHpBti7gWMfUDESV/hu8mgQ
         dF9wsLOm9sSf6wOs2cL2KlLwj2Z9qF3H/Nlm4+rxWFLftYDBqqEBAz4Iwc71NcVmEVZK
         dfVA==
X-Gm-Message-State: ACrzQf37a7cvPJgx0wU4xK1K4fiw83uIA+iddQix/oYVxRjN4EPXXCLY
        tpZUkEX27t4GZrTdR0UZxwlsJqdf4naJN/UOJy45qrnwXg==
X-Google-Smtp-Source: AMsMyM6IyQ5sGNm/pGDeJJQ5vn5WZ1By4iKoxvFogUYrIwPYfUksEqpPNIf9trER/6ncZB31spquEFt73Tpwxy4slys=
X-Received: by 2002:a4a:c10a:0:b0:476:4a59:4e4b with SMTP id
 s10-20020a4ac10a000000b004764a594e4bmr3452742oop.24.1664547082349; Fri, 30
 Sep 2022 07:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-13-brauner@kernel.org>
 <CAHC9VhSxr-aUj7mqKo05B5Oj=5FWeajx_mNjR_EszzpYR1YozA@mail.gmail.com> <53f18ae71d0b8811fbd23c87a80447bc159832e0.camel@linux.ibm.com>
In-Reply-To: <53f18ae71d0b8811fbd23c87a80447bc159832e0.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Sep 2022 10:11:11 -0400
Message-ID: <CAHC9VhRn6Lojr-ct0YJb6R6oO66-p+6Pa9YBY=bxu_wsKs9bYQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/30] integrity: implement get and set acl hook
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:19 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Paul,
>
> On Thu, 2022-09-29 at 15:14 -0400, Paul Moore wrote:
> > > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > > index bde74fcecee3..698a8ae2fe3e 100644
> > > --- a/security/integrity/ima/ima_appraise.c
> > > +++ b/security/integrity/ima/ima_appraise.c
> > > @@ -770,6 +770,15 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
> > >         return result;
> > >  }
> > >
> > > +int ima_inode_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> > > +                     const char *acl_name, struct posix_acl *kacl)
> > > +{
> > > +       if (evm_revalidate_status(acl_name))
> > > +               ima_reset_appraise_flags(d_backing_inode(dentry), 0);
> > > +
> > > +       return 0;
> > > +}
> >
> > While the ima_inode_set_acl() implementation above looks okay for the
> > remove case, I do see that the ima_inode_setxattr() function has a
> > call to validate_hash_algo() before calling
> > ima_reset_appraise_flags().  IANAIE (I Am Not An Ima Expert), but it
> > seems like we would still want that check in the ACL case.
>
> Thanks, Paul.  The "ima: fix blocking of security.ima xattrs of
> unsupported algorithms" patch in next-integrity branch, moves the hash
> algorithm checking earlier.

Okay, thanks.  When comparing against the status quo I usually just
stick with what is in Linus' tree, but I'm happy to hear this patch is
correct.

-- 
paul-moore.com
