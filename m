Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063146073D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 11:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJUJTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 05:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJUJS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:18:56 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87E7256419;
        Fri, 21 Oct 2022 02:18:41 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id t26so2059550uaj.9;
        Fri, 21 Oct 2022 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RspFCGdeHKFVtiL7mY5i6+AzFfiQ+TnzlRAcVHGM8Uw=;
        b=nhdOt3f6nhtRgIHy+opGJjTPLVS/SpUWCKN4ssz0jGxz5+NrvF1ak+DEF4wkDUfVqL
         r57aFsTkhy6kyu7rYKcTlr2dC/6PFLackRJwcXnmSB33KAYC5OmyRiDGN2BhDL+hl5p+
         lykzanUlh15HGatbmLg4sAkyt5vL6VV1u8uMNX+VeNF01q7d1Xue8M1EVpgd1OLWzspD
         IuRGTkQBhXRBW3ZNG0koUZVmqw55VPAdW6nKnOhOgnoRU8jzpjVp+KPRVMjnwTFb4/J+
         o+jSKCVIMpZXrGptMyfIgJcMTWqHWqlqXW6yZdnSLDlT+LrGC+gZKdCnWMPPmTarbp8W
         TZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RspFCGdeHKFVtiL7mY5i6+AzFfiQ+TnzlRAcVHGM8Uw=;
        b=z43bMMkVQvkfoNRRCR8Oe82DSJ8Weu7K4R2WKAQKARQDMyBBzZRb8+RlkaTCSUg0MK
         uYd+EmxwpzbdN6FLq6mHyO7VmnfCPLYzA+rdi3P3liBRDmxuNwIdCAjo/BQwLshZX9Gf
         YKyBR0jVCn20KmgmvzE27LWxIADdwbzyYjBgGCSJHfb/8WKS6OGcfRJ5tCuEDOQ59+tM
         B3sOOWbOL7OpDnkhskkIIwJI7YgvMbjIVRk/uLhgpH4+mFLd04ZbGZYpChxZ018H11ni
         kDTROEoLwpb0nEYMEECaNaPLOgpNiyiWQxyj4CExVPCkhEEWko+BLqUFR1Qs9CwjASqn
         fCfA==
X-Gm-Message-State: ACrzQf3cuAZtFwEZqbxDFvuNbejWADPLTtynL7WghjDGChtMjs2EBp4P
        neVNUJ215ebbuzixFwC5VZUoJE31UFBeErm7yu6q+cAh
X-Google-Smtp-Source: AMsMyM42DNIMYIU/A71Cdzam48ZdKegxOuiwzMH5eaGQXMQ17jcIOfFRs7Ur4irkh7zID7MmWCCp0O0e/ZaPNwwmYTU=
X-Received: by 2002:ab0:298d:0:b0:402:3608:3ec5 with SMTP id
 u13-20020ab0298d000000b0040236083ec5mr1400961uap.60.1666343920021; Fri, 21
 Oct 2022 02:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
 <20221021010310.29521-1-stephen.s.brennan@oracle.com> <20221021010310.29521-3-stephen.s.brennan@oracle.com>
 <CAOQ4uxj+ctptwuJ__gn=2URvzkXUc2NZkJaY=woGFEQQZdZn9Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxj+ctptwuJ__gn=2URvzkXUc2NZkJaY=woGFEQQZdZn9Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 Oct 2022 12:18:28 +0300
Message-ID: <CAOQ4uxh7OvmH6o1fUmMoQ_D347jVBx53TLe4R=BjtXTuvCzKCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fsnotify: Protect i_fsnotify_mask and child flags
 with inode rwsem
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 21, 2022 at 11:22 AM Amir Goldstein <amir73il@gmail.com> wrote:
...
> > +/*
> > + * Objects may need some additional actions to be taken when the last reference
> > + * is dropped. Define flags to indicate which actions are necessary.
> > + */
> > +#define FSNOTIFY_OBJ_FLAG_NEED_IPUT            0x01
> > +#define FSNOTIFY_OBJ_FLAG_UPDATE_CHILDREN      0x02
>
> with changed_flags argument, you do not need these, you can use
> the existing CONN_FLAGS.
>
> It is a bit ugly that the direction of the change is not expressed
> in changed_flags, but for the current code, it is not needed, because
> update_children does care about the direction of the change and
> the direction of change to HAS_IREF is expressed by the inode
> object return value.
>

Oh that is a lie...

return value can be non NULL because of an added mark
that wants iref and also wants to watch children, but the
only practical consequence of this is that you can only
do the WARN_ON for the else case of update_children
in fsnotify_recalc_mask().

I still think it is a win for code simplicity as I detailed
in my comments.

> Maybe try it out in v3 to see how it works.
>
> Unless Jan has an idea that will be easier to read and maintain...
>

Maybe fsnotify_update_inode_conn_flags() should return "update_flags"
and not "changed_flags", because actually the WATCHING_CHILDREN
flag is not changed by the helper itself.

Then, HAS_IREF is not returned when helper did get_iref() and changed
HAS_IREF itself and then the comment that says:
     /* Unpin inode after detach of last mark that wanted iref */
will be even clearer:

        if (want_iref) {
                /* Pin inode if any mark wants inode refcount held */
                fsnotify_get_inode_ref(fsnotify_conn_inode(conn));
                conn->flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
        } else {
                /* Unpin inode after detach of last mark that wanted iref */
                ret = inode;
                update_flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
        }

Thanks,
Amir.
