Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4A91A638C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 09:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgDMHWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 03:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgDMHWp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:22:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C3C008651;
        Mon, 13 Apr 2020 00:22:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so1990749wrx.4;
        Mon, 13 Apr 2020 00:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NDQT64IoduuWV1PLSxBoy7EoooB8WrdbKYdKX9tqgXY=;
        b=m83ojYELlpx0bApmFY7rMnf+vtJUAHIb6/WUYAEdegV7GhXJuSGrN7GOJEDCgDzpSu
         hmK7WVoe8/Bf7nDBdWQ3SqqxW5sPoEmdMQGboQ+dXdsU7aB52bjMe4BJmlLJ3X+XQW7C
         4G3f0DJc3ItU9b8GnXFfAtn47cFjoYT7Res4ophM3rnpn2kppQwlL2Jihg9r5cnvmAaT
         MJjJj+Ad7d9g75scPjXRM5LDD8Wj+0/ceQxaaaSkHbhr6236Mu2zacCOrOGJW98CuuSC
         n3fNxxznSEYqwy9pR1l3G+iBACtp6Ge/R4Yz9ChwHiy9HwCpKhJeHzow9eiU2JpeG0kS
         18Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NDQT64IoduuWV1PLSxBoy7EoooB8WrdbKYdKX9tqgXY=;
        b=i4PNN/rRSikE7VHANsRDbZ/bR9D1DJKsEvnds3ezWROmhN+D9eWYTPbcgnFgNDG4mT
         2PaBn2RK2Ao4CYEylgMTSkNyBgEm7qh1MRpEE//AIsVJ0gp7QIi8gMGDQFy9Q6hK53fc
         8JG2cUne+Ei/SWSuPPfhndeTo2sfUHfNsk9+8seZzNjN1wbcdmWecbtalDMAIqpYlxEd
         L4Q0ZRvINcWrrjJa+sPyKqWuI13pnevP3feimgHo251YF7d7DIjoE4UzARYGy6us//1w
         /hx+rJ4m4+hhT9kjL4GWLpVvf+UKrDSutROjd1CBMHTllSB2ek84GN4UdC5xqRbyZAPp
         tYKA==
X-Gm-Message-State: AGi0PuZpQbGz4c7piAtebbnHmbUptI/64paKS8uuOYcP5cRLL7BUMmoz
        kjWkZeu3qQ5frVrsctAKpOYeipHr1Oo=
X-Google-Smtp-Source: APiQypLFuGZ6xc8YBOKeXLJ6BRZq+cUb0zfn4oQAUWu/DYN8a7drP39V/2h6WQ2NBX4ihom1qQuP3w==
X-Received: by 2002:a05:6000:143:: with SMTP id r3mr16555376wrx.279.1586762563274;
        Mon, 13 Apr 2020 00:22:43 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id s6sm13319566wmh.17.2020.04.13.00.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 00:22:42 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2)
 syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
References: <20200202151907.23587-1-cyphar@cyphar.com>
 <20200202151907.23587-3-cyphar@cyphar.com>
 <1567baea-5476-6d21-4f03-142def0f62e3@gmail.com>
 <20200331143911.lokfoq3lqfri2mgy@yavin.dot.cyphar.com>
 <cd3a6aad-b906-ee57-1b5b-5939b9602ad0@gmail.com>
 <20200412164943.imwpdj5qgtyfn5de@yavin.dot.cyphar.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <cd1438ab-cfc6-b286-849e-d7de0d5c7258@gmail.com>
Date:   Mon, 13 Apr 2020 09:22:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412164943.imwpdj5qgtyfn5de@yavin.dot.cyphar.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Aleksa,

On 4/12/20 6:49 PM, Aleksa Sarai wrote:
> Sorry, I could've sworn I responded when you posted this -- comments
> below. And sorry for not getting back to you before the 5.06 release.

No worries and ahanks for your feedback below.

[...]

>>>> .\" FIXME I find the "previously-functional systems" in the previous
>>>> .\" sentence a little odd (since openat2() ia new sysycall), so I would
>>>> .\" like to clarify a little...
>>>> .\" Are you referring to the scenario where someone might take an
>>>> .\" existing application that uses openat() and replaces the uses
>>>> .\" of openat() with openat2()? In which case, is it correct to
>>>> .\" understand that you mean that one should not just indiscriminately
>>>> .\" add the RESOLVE_NO_XDEV flag to all of the openat2() calls?
>>>> .\" If I'm not on the right track, could you point me in the right
>>>> .\" direction please.
>>>
>>> This is mostly meant as a warning to hopefully avoid applications
>>> because the developer didn't realise that system paths may contain
>>> symlinks or bind-mounts. For an application which has switched to
>>> openat2() and then uses RESOLVE_NO_SYMLINKS for a non-security reason,
>>> it's possible that on some distributions (or future versions of a
>>> distribution) that their application will stop working because a system
>>> path suddenly contains a symlink or is a bind-mount.
>>>
>>> This was a concern which was brought up on LWN some time ago. If you can
>>> think of a phrasing that makes this more clear, I'd appreciate it.
>>
>> Thanks. I've made the text:
>>
>>                      Applications  that  employ  the RESOLVE_NO_XDEV flag
>>                      are encouraged to make its use configurable  (unless
>>                      it is used for a specific security purpose), as bind
>>                      mounts are widely used by end-users.   Setting  this
>>                      flag indiscriminately—i.e., for purposes not specif‐
>>                      ically related to security—for all uses of openat2()
>>                      may  result  in  spurious errors on previously-func‐
>>                      tional systems.  This may occur if, for  example,  a
>>                      system  pathname  that  is used by an application is
>>                      modified (e.g., in a new  distribution  release)  so
>>                      that  a  pathname  component  (now)  contains a bind
>>                      mount.
>>
>> Okay?
> 
> Yup,

Thanks.

> and the same text should be used for the same warning I gave for
> RESOLVE_NO_SYMLINKS (for the same reason, because system paths may
> switch to symlinks -- the prime example being what Arch Linux did
> several years ago).

Okay -- I added similar text to RESOLVE_NO_SYMLINKS.

>>>> .\" FIXME: what specific details in symlink(7) are being referred
>>>> .\" by the following sentence? It's not clear.
>>>
>>> The section on magic-links, but you're right that the sentence ordering
>>> is a bit odd. It should probably go after the first sentence.
>>
>> I must admit that I'm still confused. There's only the briefest of 
>> mentions of magic links in symlink(7). Perhaps that needs to be fixed?
> 
> It wouldn't hurt to add a longer description of magic-links in
> symlink(7). I'll send you a small patch to beef up the description (I
> had planned to include a longer rewrite with the O_EMPTYPATH patches but
> those require quite a bit more work to land).

That would be great. Thank you!

>> And, while I think of it, the text just preceding that FIXME says:
>>
>>     Due to the potential danger of unknowingly opening 
>>     these magic links, it may be preferable for users to 
>>     disable their resolution entirely.
>>
>> This sentence reads a little strangely. Could you please give me some
>> concrete examples, and I will try rewording that sentence a bit.
> 
> The primary example is that certain files (such as tty devices) are
> best not opened by an unsuspecting program (if you do not have a
> controlling TTY, and you open such a file that console becomes your
> controlling TTY unless you use O_NOCTTY).
> 
> But more generally, magic-links allow programs to be "beamed" all over
> the system (bypassing ordinary mount namespace restrictions). Since they
> are fairly rarely used intentionally by most programs, this is more of a
> tip to programmers that maybe they should play it safe and disallow
> magic-links unless they are expecting to have to use them.


I've reworked the text on RESOLVE_NO_MAGICLINKS substantially:

       RESOLVE_NO_MAGICLINKS
              Disallow all magic-link resolution during path reso‐
              lution.

              Magic links are symbolic link-like objects that  are
              most  notably  found  in  proc(5);  examples include
              /proc/[pid]/exe  and  /proc/[pid]/fd/*.   (See  sym‐
              link(7) for more details.)

              Unknowingly  opening  magic  links  can be risky for
              some applications.  Examples of such  risks  include
              the following:

              · If the process opening a pathname is a controlling
                process that currently has no controlling terminal
                (see  credentials(7)),  then  opening a magic link
                inside /proc/[pid]/fd that happens to refer  to  a
                terminal would cause the process to acquire a con‐
                trolling terminal.

              · In  a  containerized  environment,  a  magic  link
                inside  /proc  may  refer to an object outside the
                container, and thus may provide a means to  escape
                from the container.

[The above example derives from https://lwn.net/Articles/796868/]

              Because  of such risks, an application may prefer to
              disable   magic   link    resolution    using    the
              RESOLVE_NO_MAGICLINKS flag.

              If  the trailing component (i.e., basename) of path‐
              name is a magic link, and  how.flags  contains  both
              O_PATH  and O_NOFOLLOW, then an O_PATH file descrip‐
              tor referencing the magic link will be returned.

How does the above look?

Also, regarding the last paragraph, I  have a question.  The
text doesn't seem quite to relate to the rest of the discussion.
Should it be saying something like:

If the trailing component (i.e., basename) of pathname is a magic link,
**how.resolve contains RESOLVE_NO_MAGICLINKS,**
and how.flags contains both O_PATH and O_NOFOLLOW, then an O_PATH
file descriptor referencing the magic link will be returned.

?

[...]

>>>> .\" FIXME The next piece is unclear (to me). What kind of ".." escape
>>>> .\" attempts does chroot() not detect that RESOLVE_IN_ROOT does?
>>>
>>> If the root is moved, you can escape from a chroot(2). But this sentence
>>> might not really belong in a man-page since it's describing (important)
>>> aspects of the implementation and not the semantics.
>>
>> So, should I just remove the sentence?
> 
> Yup, sounds reasonable.

Done.

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
