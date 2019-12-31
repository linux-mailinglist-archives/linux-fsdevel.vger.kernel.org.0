Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490C112D90A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 14:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLaNch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 08:32:37 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46767 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfLaNch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:32:37 -0500
Received: by mail-ot1-f48.google.com with SMTP id k8so33156183otl.13;
        Tue, 31 Dec 2019 05:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rsWmXz42DgSwnorUijNfMZQZO4psLsfpHhCkGYBg2SM=;
        b=TcrmWx2kCxqHOCyHXPAuIsY1nG52sEwp7s7IpK8VrAPJ7OzyWV7kzJDUIVw1czhIvk
         Lirqcg3bbstasYMyzPjufbJHO40BnMJh7Ze0RdOFIxYTfF5QONxDlfzxxTvasBcekRVz
         60M6uEsRXD1pg4D647eEqyQjTiI56Zh7kPcuBW8KjZVNNDwo5c7a5DlMd/KwsEmTVLJG
         lLm9dYWPSGceTu3iSvx9bMaUd9JB31XkPFJ42g9O9TmwUlq++h84pRCjuwRfAw1OSXUf
         Bjx7LbkuXKx+MQSNFsM5Lp/gzn07+6B1f30is8b62ReKueqIw9iMQdMnyKpKGfQfs++/
         Ubcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rsWmXz42DgSwnorUijNfMZQZO4psLsfpHhCkGYBg2SM=;
        b=IjfQyDgO2iF38MH+NBXlK4C8jsSVEXbJQXMxZYz05J8D2xSB5gks4RbgIhw1edBcDb
         I8OLBOE4aM/J0+/DFkG5QTkYsLla25KpsEVD5W+8Myhv1qyHk9aMhrJ8ha4B98Llti2B
         rNf+hFiPedWEZiWRgC8TIh3v33rd5Rn6Iq7J86x32zbPo0bDGjad8xjPv0q4sKwsc59l
         q/JiT3xI0pUzMx+TQ4gT8ZSPivg5grGmZVLgjeJjYTEJ5aqnr88FQxClWtLWOmkCActb
         U5gP7fisFs09KSOwzmnV2YkyrJPSZqaxLPvQOs99zjJxyS9FGc+GXZjklPpjOs6j6dTA
         YIEQ==
X-Gm-Message-State: APjAAAW96X9cOjp6UkiM5nxgXVausxgjcSXx/NNmI8OF3qhhD1NNe38I
        7FSJWlxO7RYOrdWLJrmNVCR8FruWV91on6h5jBY=
X-Google-Smtp-Source: APXvYqyonat4Tzv/HfrDdUi3HNK/ecps+lZA00k+vSbDJroZ5vA/ikr9hvbsXvawwDTV6HdBCL3VmofLNOoIYjbAL7k=
X-Received: by 2002:a05:6830:145:: with SMTP id j5mr77302068otp.242.1577799156508;
 Tue, 31 Dec 2019 05:32:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Tue, 31 Dec 2019 05:32:35 -0800 (PST)
In-Reply-To: <20191229135548.qu3i3zglezlnndds@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062733epcas1p31665a3ae968ab8c70d91a3cddf529e73@epcas1p3.samsung.com>
 <20191220062419.23516-3-namjae.jeon@samsung.com> <20191229135548.qu3i3zglezlnndds@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Tue, 31 Dec 2019 22:32:35 +0900
Message-ID: <CAKYAXd9pzpQaHcuAR0N-07csf3rQskGcZU35S2Sj8y70XqgN+Q@mail.gmail.com>
Subject: Re: [PATCH v8 02/13] exfat: add super block operations
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> +	if (le16_to_cpu(p_bpb->bsx.vol_flags) & VOL_DIRTY) {
>> +		sbi->vol_flag |= VOL_DIRTY;
>> +		exfat_msg(sb, KERN_WARNING,
>> +			"Volume was not properly unmounted. Some data may be corrupt. Please
>> run fsck.");
>
> Hello, do you have some pointers which fsck tool should user run in this
> case?
Hello,
Only windows recovery tool for now. fsck in fuse-exfat is early stage yet.
So I am preparing exfat-tools included a reliable fsck.

>
>> +	}
>> +
>> +	ret = exfat_create_upcase_table(sb);
>> +	if (ret) {
>> +		exfat_msg(sb, KERN_ERR, "failed to load upcase table");
>> +		goto free_bh;
>> +	}
>> +
>> +	/* allocate-bitmap is only for exFAT */
>
> It looks like that this comment is relict from previous version which
> had also FAT32 code included...
Yes, It is leftover from vfat support in sdfat, Will remove it.

Thanks!
