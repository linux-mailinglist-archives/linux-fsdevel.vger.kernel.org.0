Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF89C892A1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 18:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfHKQe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 12:34:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35897 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfHKQe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 12:34:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so8860067wrt.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2019 09:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kqStixgjBIJ0/Wmvn1cBL0awj0K9AxRB179ZUq8Dvq8=;
        b=oR1BBWae+TDlpHjaH1AuCgT5EgHzEUWYLlv2SWfy2v6EN/y6ozPf363eHnwPHjVuAu
         C+fdmCp17f7epVAbmA0maONrczcrQao/RdLPMjA6/R07e1X9Wdgukmiv0GOxNytrdIFB
         9LtROBZW0dGY1J1HgP7jK1p247EGUiK+XDLYBBoEv6qxLw29YWBEo7bVjWbniJkShKG5
         MLVMcgThAmjv8XqHVcC4FJq8EsvcYec7gYKqsc7tAOKoaYRJo2uzJpwYJORpnd7igjSR
         aleJXAckpe1NijJaz4SY9dWeIMxv3+uRMyvVEk7q5jvz0VPbP+3ZXnIUWvz7UxszSqMi
         c93Q==
X-Gm-Message-State: APjAAAUGeAsDnjN6LH6+B7owfmMxmogBy2XksLrgU2B5mHB0XB8ITPgi
        9gXpk+CHwbsFmASWI6VDBmyzZKbQb6Y=
X-Google-Smtp-Source: APXvYqygaxt4WjgmdAJQwu8z2RjKbnkuJD8Uas+nxwNL2LLBEI6QlJDDRhn8WiTi8XYn7y0UYKZHzw==
X-Received: by 2002:adf:f404:: with SMTP id g4mr8704438wro.290.1565541297618;
        Sun, 11 Aug 2019 09:34:57 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id l17sm69115wrt.86.2019.08.11.09.34.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 09:34:56 -0700 (PDT)
Subject: Re: [PATCH v12 resend 0/1] fs: Add VirtualBox guest shared folder
 (vboxsf)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <20190811133852.5173-1-hdegoede@redhat.com>
 <8277d9de-4709-df2d-f930-d324c5764871@infradead.org>
 <68fecb6e-7afa-d39d-2f0f-5496aeff510a@redhat.com>
 <973451c9-1681-1c73-9190-75d8ef529916@infradead.org>
 <69c4d47d-2b33-72e9-9da0-7a251070cf6c@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4ba48f60-10f7-95dc-d259-68c6e3d4d026@redhat.com>
Date:   Sun, 11 Aug 2019 18:34:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <69c4d47d-2b33-72e9-9da0-7a251070cf6c@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 8/11/19 5:31 PM, Randy Dunlap wrote:
> On 8/11/19 8:16 AM, Randy Dunlap wrote:
>> On 8/11/19 8:09 AM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 8/11/19 5:07 PM, Randy Dunlap wrote:
>>>> On 8/11/19 6:38 AM, Hans de Goede wrote:
>>>>> Hello Everyone,
>>>>>
>>>>> Here is a resend of the 12th version of my cleaned-up / refactored version
>>>>> of the VirtualBox shared-folder VFS driver. It seems that for some reason
>>>>> only the cover letter of my initial-posting of v12 has made it to the list.
>>>>>
>>>>> This version hopefully addresses all issues pointed out in David Howell's
>>>>> review of v11 (thank you for the review David):
>>>>>
>>>>> Changes in v12:
>>>>> -Move make_kuid / make_kgid calls to option parsing time and add
>>>>>    uid_valid / gid_valid checks.
>>>>> -In init_fs_context call current_uid_gid() to init uid and gid
>>>>> -Validate dmode, fmode, dmask and fmask options during option parsing
>>>>> -Use correct types for various mount option variables (kuid_t, kgid_t, umode_t)
>>>>> -Some small coding-style tweaks
>>>>>
>>>>> For changes in older versions see the change log in the patch.
>>>>>
>>>>> This version has been used by several distributions (arch, Fedora) for a
>>>>> while now, so hopefully we can get this upstream soonish, please review.
>>>>
>>>> Hi,
>>>> Still looks like patch 1/1 is not hitting the mailing list.
>>>> How large is it?
>>>
>>> Thank you for catching this:
>>>
>>> [hans@dhcp-44-196 linux]$ wc 0001-fs-Add-VirtualBox-guest-shared-folder-vboxsf-support.patch
>>>    3754  14479 100991 0001-fs-Add-VirtualBox-guest-shared-folder-vboxsf-support.patch
>>
>> That size shouldn't be a problem AFAIK.
>> Maybe there is something else in the patch that vger doesn't like.
>>
>>    http://vger.kernel.org/majordomo-taboos.txt
>>
> 
> "Message size exceeding 100 000 characters causes blocking."
> from:  http://vger.kernel.org/majordomo-info.html
> 
> I thought the limit was higher than that.

Thank you for this info. I've trimmed the changelog below the ---
in the commit messages, moving it to the coverletter, this
brings the size down to aprox. 96000 chars and I've done another
resend. Can you please let me know (offlist) if this one has
successfully made it to the list?

Regards,

Hans

