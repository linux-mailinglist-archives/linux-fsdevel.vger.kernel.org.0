Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA726ED1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 21:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfEVT0E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 15:26:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43119 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731844AbfEVT0D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 15:26:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id i8so3148441oth.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ewqKT8bg+GlNvY1OOB7hliqi09oPFaNl8uDtycn8IEs=;
        b=XAvqPPZEoSxSai//AanqhMiByOerVUTFMO73VF3TBU/mQxESN3HSR5+8AFmpT1Fne/
         5awv4yOF0Jjtj0irCoAW2zAZmqpXdykPyR9hf3GhWeWF//j9JuyFWMjHwJDxG/K2udT8
         njAD5vUNkb+1XkiCPrEUKygr9MUdswUEUsqoRRmvjUCd4XaCWPEIvxbPNtrevCnVIchU
         bFS2XIiaAHK616aAazWSdLCFwlMmu39L0xxxY/LjwPNNkIJT23VbgOHNpZZkwtqoX5RW
         ZvbA9fDYAGlWWZDW9m//S37TJr/H+nR8pacFLxUbbofKyNkSBgG4XSFxKzFpRxrHDlVs
         VKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ewqKT8bg+GlNvY1OOB7hliqi09oPFaNl8uDtycn8IEs=;
        b=N8ox033ceHgO+KhIo90zpluSAeRaQdyhxvMurwfp0iPsQfzmFJohflL1mE7tw7tJQN
         LoDjRETUYaQ/iURfOGPaUrtEHNQo0hFB0OYNWBxXzbFzHyFV4hRZRzhGuyonQJwBaTeR
         Wp6/GTJwYKqhDHGGnXatraMBvduLOpHPouq7bbRt2ddll5AF3QC8Ge3U0LwX0F4q9JLg
         1fyvnLPvd8PWmh8xFWpg9IfEaWFfmLbAOqcbYBp+MBp7SuCQuAjLOZJK6CwFfgSW9fTl
         +qqKN36IIl1PzQmdRfTAA9mINlVBXWrEYo6jmoZmgYP7mjopn0vrTR+GVGWMSt+StFg6
         jRLw==
X-Gm-Message-State: APjAAAW66OJkTt8FJoe2iVpETTEa39EaChn19dKjNrKdYdPGOp3u8agc
        DjDGWKdsqFa8n1NAiFF3FMBl6Q==
X-Google-Smtp-Source: APXvYqwF1jORb8TOhDGfqbcMG9dQkinGDO6QrFqO1Wiq5VBykQAkW6XmyAVRZb76ov2DZIPk+Jz8MA==
X-Received: by 2002:a9d:4a84:: with SMTP id i4mr45623913otf.148.1558553162179;
        Wed, 22 May 2019 12:26:02 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id x64sm9746168oia.32.2019.05.22.12.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:26:01 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
To:     hpa@zytor.com, Roberto Sassu <roberto.sassu@huawei.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de,
        james.w.mcmechan@gmail.com, niveditas98@gmail.com
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
 <20190517165519.11507-3-roberto.sassu@huawei.com>
 <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
 <20190517210219.GA5998@rani.riverdale.lan>
 <d48f35a1-aab1-2f20-2e91-5e81a84b107f@zytor.com>
 <20190517221731.GA11358@rani.riverdale.lan>
 <7bdca169-7a01-8c55-40e4-a832e876a0e5@huawei.com>
 <9C5B9F98-2067-43D3-B149-57613F38DCD4@zytor.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <3839583c-5466-6573-3048-0da7e6778c88@landley.net>
Date:   Wed, 22 May 2019 14:26:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9C5B9F98-2067-43D3-B149-57613F38DCD4@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/22/19 11:17 AM, hpa@zytor.com wrote:
> On May 20, 2019 2:39:46 AM PDT, Roberto Sassu <roberto.sassu@huawei.com> wrote:
>> On 5/18/2019 12:17 AM, Arvind Sankar wrote:
>>> On Fri, May 17, 2019 at 02:47:31PM -0700, H. Peter Anvin wrote:
>>>> On 5/17/19 2:02 PM, Arvind Sankar wrote:
>>>>> On Fri, May 17, 2019 at 01:18:11PM -0700, hpa@zytor.com wrote:
>>>>>>
>>>>>> Ok... I just realized this does not work for a modular initramfs,
>> composed at load time from multiple files, which is a very real
>> problem. Should be easy enough to deal with: instead of one large file,
>> use one companion file per source file, perhaps something like
>> filename..xattrs (suggesting double dots to make it less likely to
>> conflict with a "real" file.) No leading dot, as it makes it more
>> likely that archivers will sort them before the file proper.
>>>>> This version of the patch was changed from the previous one exactly
>> to deal with this case --
>>>>> it allows for the bootloader to load multiple initramfs archives,
>> each
>>>>> with its own .xattr-list file, and to have that work properly.
>>>>> Could you elaborate on the issue that you see?
>>>>>
>>>>
>>>> Well, for one thing, how do you define "cpio archive", each with its
>> own
>>>> .xattr-list file? Second, that would seem to depend on the ordering,
>> no,
>>>> in which case you depend critically on .xattr-list file following
>> the
>>>> files, which most archivers won't do.
>>>>
>>>> Either way it seems cleaner to have this per file; especially if/as
>> it
>>>> can be done without actually mucking up the format.
>>>>
>>>> I need to run, but I'll post a more detailed explanation of what I
>> did
>>>> in a little bit.
>>>>
>>>> 	-hpa
>>>>
>>> Not sure what you mean by how do I define it? Each cpio archive will
>>> contain its own .xattr-list file with signatures for the files within
>>> it, that was the idea.
>>>
>>> You need to review the code more closely I think -- it does not
>> depend
>>> on the .xattr-list file following the files to which it applies.
>>>
>>> The code first extracts .xattr-list as though it was a regular file.
>> If
>>> a later dupe shows up (presumably from a second archive, although the
>>> patch will actually allow a second one in the same archive), it will
>>> then process the existing .xattr-list file and apply the attributes
>>> listed within it. It then will proceed to read the second one and
>>> overwrite the first one with it (this is the normal behaviour in the
>>> kernel cpio parser). At the end once all the archives have been
>>> extracted, if there is an .xattr-list file in the rootfs it will be
>>> parsed (it would've been the last one encountered, which hasn't been
>>> parsed yet, just extracted).
>>>
>>> Regarding the idea to use the high 16 bits of the mode field in
>>> the header that's another possibility. It would just require
>> additional
>>> support in the program that actually creates the archive though,
>> which
>>> the current patch doesn't.
>>
>> Yes, for adding signatures for a subset of files, no changes to the ram
>> disk generator are necessary. Everything is done by a custom module. To
>> support a generic use case, it would be necessary to modify the
>> generator to execute getfattr and the awk script after files have been
>> placed in the temporary directory.
>>
>> If I understood the new proposal correctly, it would be task for cpio
>> to
>> read file metadata after the content and create a new record for each
>> file with mode 0x18000, type of metadata encoded in the file name and
>> metadata as file content. I don't know how easy it would be to modify
>> cpio. Probably the amount of changes would be reasonable.

I could make toybox cpio do it in a weekend, and could probably throw a patch at
usr/gen_init_cpio.c while I'm at it. I prototyped something like that a couple
years ago, it's not hard.

The real question is scripts/gen_initramfs_list.sh and the text format it
produces. We can currently generate cpio files with different ownership and
permissions than the host system can represent (when not building as root, on a
filesystem that may not support xattrs or would get unhappy about conflicting
selinux annotations). We work around it by having the metadata represented
textually in the initramfs_list file gen_initramfs_list.sh produces and
gen_init_cpio.c consumes.

xattrs are a terrible idea the Macintosh invented so Finder could remember where
you moved a file's icon in its folder without having to modify the file, and
then things like OS/2 copied it and Windows picked it up from there and went "Of
course, this is a security mechanism!" and... sigh.

This is "data that is not data", it's metadata of unbounded size. It seems like
it should go in gen_initramfs_list.sh but as what, keyword=value pairs that
might have embedded newlines in them? A base64 encoding? Something else?

>> The kernel will behave in a similar way. It will call do_readxattrs()
>> in
>> do_copy() for each file. Since the only difference between the current
>> and the new proposal would be two additional calls to do_readxattrs()
>> in
>> do_name() and unpack_to_rootfs(), maybe we could support both.
>>
>> Roberto
> 
> The nice thing with explicit metadata is that it doesn't have to contain the filename per se, and each file is self-contained. There is a reason why each cpio header starts with the magic number: each cpio record is formally independent and can be processed in isolation.  The TRAILER!!! thing is a huge wart in the format, although in practice TRAILER!!! always has a mode of 0 and so can be distinguished from an actual file.

Not adding the requirement that the cpio.gz must be generated as root from a
filesystem with the same users and selinux rules as the target system would be nice.

> The use of mode 0x18000 for metadata allows for optional backwards compatibility for extraction; for encoding this can be handled with very simple postprocessing.

The representation within the cpio file was never a huge deal to me. 0x18000
sounds fine for that.

> So my suggestion would be to have mode 0x18000 indicate extended file metadata, with the filename of the form:
> 
> optional_filename!XXXXX!
> 
> ... where XXXXX indicates the type of metadata (e.g. !XATTR!). The optional_filename prefix allows an unaware decoder to extract to a well-defined name; simple postprocessing would be able to either remove (for size) or add (for compatibility) this prefix. It would be an error for this prefix, if present, to not match the name of the previous file.

I'd suggest METADATA!!! to look like TRAILER!!!. (METADATA!!!XXXXX! if you
really think a keyword=value pair store is _not_ universal and we're going to
invent entire new _categories_ of this side channel nonsense.)

And extracting conflicting filenames is presumably already covered, it either
replaces or the new one fails to create the file and the extractor moves on.
(You need a working error recovery path that skips the right amount of data so
you can handle the next file properly, but you should have that anyway.)

Rob
