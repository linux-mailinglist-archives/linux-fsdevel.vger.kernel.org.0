Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3086781B91
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Aug 2023 02:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjHTAKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Aug 2023 20:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjHTAKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:10:07 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71337963BA;
        Sat, 19 Aug 2023 13:03:41 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1c0fcbf7ae4so1459232fac.0;
        Sat, 19 Aug 2023 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692475421; x=1693080221;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aJmwmCW2cEQCd04RE4RrxWMNws0AbxA5Q61XDGT3T+Y=;
        b=g+rCERemWikecerpqjEDtuCW3J3jHkNm2Fn5WiZ00kYiXRoMVCXXROJJpfAhc15ysl
         UWyXlVSZpz35w9DMq98q4cOxdVKV1k7EtA3CBAk8rCr20aJ/nHENESikDfhiZEiJEyFo
         yTLrMLCL1aTFaD2s021AVlUAsULlYgxSb4homYRDe3mtKQgj76vSGFVxcQd3pRccd42Z
         SlSgLj/i64i7MMUYTgel3/XsUsGJY9+5Za+GFigyUJTVhq09oXN0yrnplUVftBvbvW92
         lJDC2OQrmljAnyqavE9PxuqenvyqAGHnmcXJ2Fq7fuUAF6qD65/hWv45bAEK6auxe91l
         I3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692475421; x=1693080221;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJmwmCW2cEQCd04RE4RrxWMNws0AbxA5Q61XDGT3T+Y=;
        b=VdABrbmZ4sjmz6Q/LPLTOuPC0hRoaMZ6wOyIzTwht/doCUJR7yA61EqGeWYwQRwh0M
         5jAbaPqtl0d5M5OjyCllnXqw3LR/2uT9SSzBI+8y3vWq6BdeWzCqi+a0OSoeeHEU6p0N
         2wE4NSe6Dn0H2Ow+e2ChzE31Lgst0wjCKPuh912LeQ6zVDE99YiNWWzgMZzs2FwjrCrX
         pAx2r2XOCyE3t2RonYQ2yEaHuCsomdF0OHs478VcShEK3lgHno22KEN4t2cAfoPoEkR4
         ahOvWdCkYprGz+nsD3/Wbqv3U46R7elFpCZ8b6UMU0lo0zeKBWmma0JdLSiYElwkrWYE
         u0Pg==
X-Gm-Message-State: AOJu0YweKrWIbvDdRJXErf5XaC7/TcZEM7wTcMqp7E7j8GMYq8pn6GeZ
        g4FGaKRYlfHmLqSP1WVGA63crSPw1AVw7aNjVjw=
X-Google-Smtp-Source: AGHT+IFcQ5JgHH5X+0iR2/3eAmurP/E4fqkFweod4P5W5Y3dD5jml27OqGCNcTMGfxg3F0F72tWMGlj2+wEF2tqx2qQ=
X-Received: by 2002:a05:6870:6394:b0:1c1:12dc:70b1 with SMTP id
 t20-20020a056870639400b001c112dc70b1mr3579234oap.57.1692475420635; Sat, 19
 Aug 2023 13:03:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:79d9:0:b0:4f0:1250:dd51 with HTTP; Sat, 19 Aug 2023
 13:03:40 -0700 (PDT)
In-Reply-To: <20230819-geblendet-energetisch-a90a2886216c@brauner>
References: <000000000000c74d44060334d476@google.com> <87o7j471v8.fsf@email.froward.int.ebiederm.org>
 <202308181030.0DA3FD14@keescook> <20230818191239.3cprv2wncyyy5yxj@f> <20230819-geblendet-energetisch-a90a2886216c@brauner>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sat, 19 Aug 2023 22:03:40 +0200
Message-ID: <CAGudoHGnE2=+EqnwjkSD48VvGpK8MVAvYXQeTxA1o=PfOqHQnA@mail.gmail.com>
Subject: Re: [syzbot] [ntfs?] WARNING in do_open_execat
To:     Christian Brauner <brauner@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com>,
        anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/19/23, Christian Brauner <brauner@kernel.org> wrote:
> On Fri, Aug 18, 2023 at 09:12:39PM +0200, Mateusz Guzik wrote:
>> On Fri, Aug 18, 2023 at 10:33:26AM -0700, Kees Cook wrote:
>> > This is a double-check I left in place, since it shouldn't have been
>> > reachable:
>> >
>> >         /*
>> >          * may_open() has already checked for this, so it should be
>> >          * impossible to trip now. But we need to be extra cautious
>> >          * and check again at the very end too.
>> >          */
>> >         err = -EACCES;
>> >         if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
>> >                          path_noexec(&file->f_path)))
>> >                 goto exit;
>> >
>>
>> As I mentioned in my other e-mail, the check is racy -- an unlucky
>> enough remounting with noexec should trip over it, and probably a chmod
>> too.
>>
>> However, that's not what triggers the warn in this case.
>>
>> The ntfs image used here is intentionally corrupted and the inode at
>> hand has a mode of 777 (as in type not specified).
>>
>> Then the type check in may_open():
>>         switch (inode->i_mode & S_IFMT) {
>>
>> fails to match anything.
>>
>> This debug printk:
>> diff --git a/fs/namei.c b/fs/namei.c
>> index e56ff39a79bc..05652e8a1069 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -3259,6 +3259,10 @@ static int may_open(struct mnt_idmap *idmap, const
>> struct path *path,
>>                 if ((acc_mode & MAY_EXEC) && path_noexec(path))
>>                         return -EACCES;
>>                 break;
>> +       default:
>> +               /* bogus mode! */
>> +               printk(KERN_EMERG "got bogus mode inode!\n");
>> +               return -EACCES;
>>         }
>>
>>         error = inode_permission(idmap, inode, MAY_OPEN | acc_mode);
>>
>> catches it.
>>
>> All that said, I think adding a WARN_ONCE here is prudent, but I
>> don't know if denying literally all opts is the way to go.
>>
>> Do other filesystems have provisions to prevent inodes like this from
>> getting here?
>
> Bugs reported against the VFS from ntfs/ntfs3 are to be treated with
> extreme caution. Frankly, if it isn't reproducible without a corrupted
> ntfs/ntfs3 image it is to be dismissed until further notice.
>
> In this case it simply seems that ntfs is failing at ensuring that its
> own inodes it reads from disk have a well-defined type.
>
> If ntfs fails to validate that its own inodes it puts into the icache
> are correctly initialized then the vfs doesn't need to try and taper
> over this.
>
> If ntfs fails at that, there's no guarantee that it doesn't also fail at
> setting the correct i_ops for that inode. At which point we can check
> the type in may_open() but we already used bogus i_ops the whole time on
> some other inodes.
>
> We're not here to make up for silly bugs like this. That WARN belongs
> into ntfs not the vfs.
>

Given the triggered WARN_ON it seemed to me this would be the
operating procedure, I am happy it is not ;)

Per your description and the one provided by Theodore I take it
filesystems must not ship botched inodes like this one.

While in this case this is a clear-cut bug in ntfs, I would argue the
entire ordeal exposes a deficiency in VFS -- it should have a
debug-only mechanism which catches cases like this early on. For
example there could be a mandatory function to call when the
filesystem claims it constructed the inode to assert a bunch on it --
it would not catch all possible problems, but would definitely catch
this one (and VFS would have to detect the call was not made).

Perhaps I should write a separate e-mail about this, but I'm surprised
there is no debug-only (as in not present in production kernels)
support for asserting the state. To give one example which makes me
itchy see inode destruction. There are few checks in clear_inode, but
past that there is almost nothing.

Similarly there are quite a few comments how the caller is required to
hold a given lock, which should have been converted to lockdep asserts
years ago.

I'm going to write something up later.

-- 
Mateusz Guzik <mjguzik gmail.com>
