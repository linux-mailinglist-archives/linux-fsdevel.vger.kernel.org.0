Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DD013D5CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 09:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgAPITO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 03:19:14 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:47493 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbgAPITO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:19:14 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MCJvA-1ijn9g2WJO-009Pbj; Thu, 16 Jan 2020 09:19:02 +0100
Subject: Re: [PATCH v2] binfmt_misc: pass info about P flag by AT_FLAGS
To:     YunQiang Su <syq@debian.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        YunQiang Su <ysu@wavecomp.com>
References: <20200116022049.164659-1-syq@debian.org>
 <7af5c24d-dd24-b728-92cf-a5a759787590@vivier.eu>
 <CAKcpw6VEVaeBA9y1UC+vMzM=u9q4mc4Mr3FWewxDFkFBBtV1xA@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a699c524-f7e6-c517-60c7-20cf182c286c@vivier.eu>
Date:   Thu, 16 Jan 2020 09:18:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAKcpw6VEVaeBA9y1UC+vMzM=u9q4mc4Mr3FWewxDFkFBBtV1xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5gekEDFq6ApMxdo31EQO60DK7ecvC29vrFCg7fqkyJ+zYysBube
 EQp7lW8LyhYv76QADEzx6PYIAw83sXQblbzHFyJkfU+/VolHIX2JVL0TsSjQhbR0FID/5v+
 /gXuTFyEmnCMa6ZowrmiatfMxtZF3Z6lCT84B5r8dDeGKL+BcBLfDhQmv0EXhdfxlDI8uTN
 Gc4rtn/5sIwP6oHnPtiIg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4YSYlm/zXA4=:/eDQLBj82Lwx9VbR5sdGLD
 pcWWeQ4bDgoWiRTf5Q1EiQmA1VC4uXu4Y49IxwYMt1GAuOnvJHXzMOeLFC7c5Scqw2XpA36Ge
 kYDCS+UvZUa0PhObL2OgK8mHGvRBnArimpa5sVaOp54qOvGzKmWGGyha8iAOXQKuDbqNBwBnd
 3Xe4vLbxNhaQy9FVSO2hJ9GFm2Q3IJe0a7zcTihaARTGjm5K4GGNwFOysDXk1kMiwyDoJGkCL
 IQ2xUduL9zUwUUbhL9+Xg4bakcpQIQeuEdXxsDz6xYKvRBJiBYQCj8SBaVXF06dpcY5AI7qGe
 Z0J9TvzmF+urp9pxGoYSRAEY0/UAlh/MxRYpVQp1TQtM3IVDXnfnD1Gl8uVtbVQ5RWVt0SyQI
 igYNeDfQgAdk+7/cTY53gDH/iUyDUZCzJXZqfdrwPYtYl3o+YknZSl8Icn7Sum6hZCBXKbx0A
 wW4KH0YUNFBIbj0/h3X83ISQtPZCcgZp6Xyw2QX/E0ttBLN84UM92DcMgUghvfTirsEO2R2Zc
 9TZKSgmR7tbfnHr0P5CL2CcyblXYwavFbjlRH4TqqBdZRKZlJI9UQINd9ug3XJitCcTygifpX
 87C5ROypcGt3Ikuz6+gZthHk9uw1dj058SGjVjNcZ83Y+S/WyB3o51RGyOx01uE442dug715H
 okliyOsan606lQyKuBiicPQ7nWmZBkHiSRFhZke6tqEdlmDG0Hk3cVFNrwTXg88lJw1JUJ4Vs
 A5C55l2hNn20AqZsd5V0Rl5nUgaapZmpV4/jFg3z0RL24KoHxoD0n4q8mPSrBnv138NsEhk/S
 mKaXcJ89BQ2jGBL7tZUbLFuVRCNDDTxy30fLOLY5qj9nnoDcSys0NrtjaL2HlMzdhyFbG9vxs
 7gvcGXv8ZdgGBuNKWkT7F047r6SAyQQzr+eYhHI8jUSQkRRK3br9AWgo8KXoIz9HDA5QaZIp/
 s8Jzsh3hrNOC6aGB/8IaVZdlr/QacUlV9Orvv+tssm6UB3xzhbOMMg1AI8ctcaMSjzLoXnxnH
 pv9IsMeG3pstC8kBPjo1fbHELachBsyfzgDIWqdr1OtY
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 16/01/2020 à 09:17, YunQiang Su a écrit :
> Laurent Vivier <laurent@vivier.eu> 于2020年1月16日周四 下午4:07写道：
>>
>> Le 16/01/2020 à 03:20, YunQiang Su a écrit :
>>> From: YunQiang Su <ysu@wavecomp.com>
>>>
>>> Currently program invoked by binfmt_misc cannot be aware about whether
>>> P flag, aka preserve path is enabled.
>>>
>>> Some applications like qemu need to know since it has 2 use case:
>>>   1. call by hand, like: qemu-mipsel-static test.app OPTION
>>>      so, qemu have to assume that P option is not enabled.
>>>   2. call by binfmt_misc. If qemu cannot know about whether P flag is
>>>      enabled, distribution's have to set qemu without P flag, and
>>>      binfmt_misc call qemu like:
>>>        qemu-mipsel-static /absolute/path/to/test.app OPTION
>>>      even test.app is not called by absoulute path, like
>>>        ./relative/path/to/test.app
>>>
>>> This patch passes this information by the 3rd bits of unused AT_FLAGS.
>>> Then, in qemu, we can get this info by:
>>>    getauxval(AT_FLAGS) & (1<<3)
>>>
>>> v1->v2:
>>>   not enable kdebug
>>>
>>> See: https://bugs.launchpad.net/qemu/+bug/1818483
>>> Signed-off-by: YunQiang Su <ysu@wavecomp.com>
>>> ---
>>>  fs/binfmt_elf.c         | 6 +++++-
>>>  fs/binfmt_elf_fdpic.c   | 6 +++++-
>>>  fs/binfmt_misc.c        | 2 ++
>>>  include/linux/binfmts.h | 4 ++++
>>>  4 files changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>>> index f4713ea76e82..d33ee07d7f57 100644
>>> --- a/fs/binfmt_elf.c
>>> +++ b/fs/binfmt_elf.c
>>> @@ -178,6 +178,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>>>       unsigned char k_rand_bytes[16];
>>>       int items;
>>>       elf_addr_t *elf_info;
>>> +     elf_addr_t flags = 0;
>>>       int ei_index;
>>>       const struct cred *cred = current_cred();
>>>       struct vm_area_struct *vma;
>>> @@ -252,7 +253,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>>>       NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
>>>       NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>>>       NEW_AUX_ENT(AT_BASE, interp_load_addr);
>>> -     NEW_AUX_ENT(AT_FLAGS, 0);
>>> +     if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0) {
>>> +             flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
>>> +     }
>>
>> Perhaps we also need a different flag in AT_FLAG than in interp_flag as
>> BINPRM_FLAGS_PRESERVE_ARGV0 is also part of the internal ABI?
> 
> yep. It may be really a problem.
> So, should we define a set of new macros for AT_FLAGS?

Yes, I think.

Thanks,
Laurent
