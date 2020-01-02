Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C60812E587
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 12:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgABLLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 06:11:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39228 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgABLLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:11:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so56564032oty.6;
        Thu, 02 Jan 2020 03:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lJv/sGamCsPGIzZo8ylSMHSYu87RpYOKF5XXlTD11As=;
        b=rdx9u2/0F8mDVBh8cLkBvEZu5bK10KX7ZJ/uhkZz3819AR84f7KeoMsDCacgHhQNBD
         Z649Sim2THydSXNXpc5U+mZ9qJb3B30viRCLVcogQEuIdV4IotTmEiyAQ30ZyQOVHsW2
         0Qdwpve43tb+jZQuYQUqv8cX82b8tmESY23IBm9fAaxKNg6LhDNfgftSsc6FcbFNF7FY
         RqB5WmGikQDynkxvHM4Gx3vc2g3AMzAGFjl110uOetHuMtrEAwpi/DzPjpEyPXTPu4g2
         tqDIs/fEer1+HdiM7oWQXrkZ3aQu6yRlHVon8v75I/UMLSkjHcmy4jrGbijfR4z1TjI1
         9WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lJv/sGamCsPGIzZo8ylSMHSYu87RpYOKF5XXlTD11As=;
        b=Vl+MhL7cFd1GLGoeUelYeqI0NM1Fcf5CeuoQV1DGdgbFpKCFVESio+xexxZ+wUn1kC
         oBEspg1uyS+yfNc34VdzAlsYlCJEM/WcC/vj/+dhJ6J8EtvjoVQUDBuHgT+HN3NmeDkx
         Jee1W6TgyekzB7YzymMmzI1sADgv1sBMn4gEjBH+GBkOJ4giVDwYih0RugBK2uETMtiW
         IrOwUsEsEj75dDE4FgKw42VUqPYeKej0aCnffNQgREGEgNFVPRAPgfJT4L01lOIOd9fv
         FdRxaOWZqqFjREAd3e1QoNqPc9101L1xXmXkIZkfQ1p8BLa3J+XQGdfdTuAoJpaqJFa7
         Kgpg==
X-Gm-Message-State: APjAAAWoDo68nxdiYIeuKVv2gG98vNVw0fuPfNINDNPBI1xT09P9pIBs
        NTvlRje/c6bRB5ZjESqKGZrcHMTPnX056OaqUxU=
X-Google-Smtp-Source: APXvYqwCbvnwXKd4CdiE90h+yoBsoKxLpJ0Xd8NGFXH1EC9//GJi45HpBQW8nxwCyJKpgJhkFkj3KfcdDoWnSu3i3Ag=
X-Received: by 2002:a05:6830:1691:: with SMTP id k17mr94660414otr.282.1577963498118;
 Thu, 02 Jan 2020 03:11:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Thu, 2 Jan 2020 03:11:37 -0800 (PST)
In-Reply-To: <20200102110604.acdilxek5w22q5bg@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062732epcas1p17f3b1066fb4d6496559f349f950e1751@epcas1p1.samsung.com>
 <20191220062419.23516-2-namjae.jeon@samsung.com> <20191229141108.ufnu6lbu7qvl5oxj@pali>
 <20200102110604.acdilxek5w22q5bg@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Thu, 2 Jan 2020 20:11:37 +0900
Message-ID: <CAKYAXd9HVGCGfX+6V_zi=BfFpYkLjN1zwB73Awvomd-NTNi8bQ@mail.gmail.com>
Subject: Re: [PATCH v8 01/13] exfat: add in-memory and on-disk structures and headers
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-01-02 20:06 GMT+09:00, Pali Roh=C3=A1r <pali.rohar@gmail.com>:
> Hello, just remainder for question below, so it would not be lost.
>
> I guess that if comment for structure says that it needs to have exact
> size then structure should be marked as packed to prevent any unexpected
> paddings added by compiler (as IIRC compiler is free to add any padding
> between any structure members).
Okay, I will fix it on next version.

Thanks!
>
> On Sunday 29 December 2019 15:11:08 Pali Roh=C3=A1r wrote:
>> On Friday 20 December 2019 01:24:07 Namjae Jeon wrote:
>> > +
>> > +#define JUMP_BOOT_LEN			3
>> > +#define OEM_NAME_LEN			8
>> > +#define MUST_BE_ZERO_LEN		53
>> > +#define EXFAT_FILE_NAME_LEN		15
>> > +
>> > +/* EXFAT BIOS parameter block (64 bytes) */
>> > +struct bpb64 {
>> > +	__u8 jmp_boot[JUMP_BOOT_LEN];
>> > +	__u8 oem_name[OEM_NAME_LEN];
>> > +	__u8 res_zero[MUST_BE_ZERO_LEN];
>> > +};
>> > +
>> > +/* EXFAT EXTEND BIOS parameter block (56 bytes) */
>> > +struct bsx64 {
>> > +	__le64 vol_offset;
>> > +	__le64 vol_length;
>> > +	__le32 fat_offset;
>> > +	__le32 fat_length;
>> > +	__le32 clu_offset;
>> > +	__le32 clu_count;
>> > +	__le32 root_cluster;
>> > +	__le32 vol_serial;
>> > +	__u8 fs_version[2];
>> > +	__le16 vol_flags;
>> > +	__u8 sect_size_bits;
>> > +	__u8 sect_per_clus_bits;
>> > +	__u8 num_fats;
>> > +	__u8 phy_drv_no;
>> > +	__u8 perc_in_use;
>> > +	__u8 reserved2[7];
>> > +};
>>
>> Should not be this structure marked as packed? Also those two below.
>>
>> > +/* EXFAT PBR[BPB+BSX] (120 bytes) */
>> > +struct pbr64 {
>> > +	struct bpb64 bpb;
>> > +	struct bsx64 bsx;
>> > +};
>> > +
>> > +/* Common PBR[Partition Boot Record] (512 bytes) */
>> > +struct pbr {
>> > +	union {
>> > +		__u8 raw[64];
>> > +		struct bpb64 f64;
>> > +	} bpb;
>> > +	union {
>> > +		__u8 raw[56];
>> > +		struct bsx64 f64;
>> > +	} bsx;
>> > +	__u8 boot_code[390];
>> > +	__le16 signature;
>> > +};
>>
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
>
