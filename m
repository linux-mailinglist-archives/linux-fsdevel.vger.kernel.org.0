Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA8B140983
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 13:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgAQMM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 07:12:28 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40322 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgAQMM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:12:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id w21so22308496otj.7;
        Fri, 17 Jan 2020 04:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9SipFQDZMfh5nN61PgcRgYvn1abFwxa06FXqcHxDhSs=;
        b=BB7df+OmFFliSMdJToQQh1paKBtINwz5yQyS7lMeyXt0vtnk0DTfMwkXg8IIZp7Bpt
         0OXEgqPFqtMvnKqHs0RwfT1i9qLMU4hNNDRzkI9r9w0uQJdfKHXQTNM6+HcbU+LodvO/
         efbKGDpDsol5dsVVCG9aLHzGfWVMDo2R1JskIiZiT8dNh1Y5Rx9YUcnJ73Pf3QsYMe1z
         NSy8ovFh/vpf8tsEV4BkCQBdL+DBRnvPr2N0fqL8Bw1A2e/k4mODx01CfGCu4Zo3LsIw
         vGs8JaSND88CE7nBBIrpGV9rZpO893zB2gMdD7zGUbSR18gj40QIl8J4Cv3LyZjpjnVf
         QOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9SipFQDZMfh5nN61PgcRgYvn1abFwxa06FXqcHxDhSs=;
        b=bqjijnxFv8kOfF5SdMIBPiDqva8ArByv0ZyA7SYyQPs3ATMM9mBVgu4YdmCJfXxwaC
         AKGfuEjMLy0zXttV5NRic11a2nb4pMz96YAtQxW65DtEOmlrccH4qAkjYS0vARxhmqpJ
         5BgJH423X06w1rwKoXsMkxBOVNhjgYyaIjam4FvsVDsdB/wtkOiFNJzkjOV4NYmntHHb
         tt1Cnh0j6XeLlh8b2F2RCzaP5nDaDWGFcb7FGtL9s6QQ+gxgSMetLFgSQpU7oDOPpiqP
         AdZlLkrKzGRsd8QgpZ/IOal1271YXEIfWcfFxKKTailS8PIOPUFQAEulm/u6FnQXeplF
         ypKA==
X-Gm-Message-State: APjAAAUM42ZM1KRdJDQ/IgYFinFZdMZYqlcvHvy9HjZ03uJjPUV5TPvx
        pHEHvW1PlCxOulUnJ6KvCRWP1zGaV2nDvOMhKMq1lA==
X-Google-Smtp-Source: APXvYqyzalqLo5MUDFV8PCj3/5VknpA5M9FAIJVuSJdTdhIEmaFBni96SkZGxff4yw5BvxxaXnCzOIGTHpBpKbVhkpQ=
X-Received: by 2002:a05:6830:145:: with SMTP id j5mr5618327otp.242.1579263147096;
 Fri, 17 Jan 2020 04:12:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Fri, 17 Jan 2020 04:12:26 -0800 (PST)
In-Reply-To: <20200117091813.wiksrz5khmtoocbj@pali>
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
 <CGME20200115082821epcas1p4d76d8668dfac70ae3e3889d4ccb6c3ee@epcas1p4.samsung.com>
 <20200115082447.19520-6-namjae.jeon@samsung.com> <20200117091813.wiksrz5khmtoocbj@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Fri, 17 Jan 2020 20:12:26 +0800
Message-ID: <CAKYAXd9mcsZYp_EuPx_5KACW7oPvtTmWmxHgCsy1PgOZskJjyg@mail.gmail.com>
Subject: Re: [PATCH v10 05/14] exfat: add file operations
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-01-17 17:18 GMT+08:00, Pali Roh=C3=A1r <pali.rohar@gmail.com>:
> On Wednesday 15 January 2020 17:24:38 Namjae Jeon wrote:
>> This adds the implementation of file operations for exfat.
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
>> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
>> ---
>>  fs/exfat/file.c | 355 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 355 insertions(+)
>>  create mode 100644 fs/exfat/file.c
>>
>> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
>> new file mode 100644
>> index 000000000000..b4b8af0cae0a
>> --- /dev/null
>> +++ b/fs/exfat/file.c
>
> ...
>
>> +/* resize the file length */
>> +int __exfat_truncate(struct inode *inode, loff_t new_size)
>> +{
>
> ...
>
>> +
>> +		ktime_get_real_ts64(&ts);
>> +		exfat_set_entry_time(sbi, &ts,
>> +				&ep->dentry.file.modify_time,
>> +				&ep->dentry.file.modify_date,
>> +				&ep->dentry.file.modify_tz);
>
> Hello! Now I spotted that you forgot to update "modify_time_ms" entry.
Good catch:)
>
> To prevent this problem, maybe function modify_time_ms() could take
> another (optional) parameter for specifying time_ms?
Okay, I will change exfat_set/get_entry_time to take a time_ms argument.
Thanks for your review!
