Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76222197776
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 11:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgC3JIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 05:08:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39565 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbgC3JIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:08:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so20612723wrt.6;
        Mon, 30 Mar 2020 02:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bTYehEJibc5NpezL2miOM2UdvHHV5lxW3CvlvcvUFZc=;
        b=skx0J5EJ+LeY2Xp5xogjkpxx/vhzk/uPCt6wTntQ2gWmUK4+NB8zoW0hukUsmSF0nD
         zKLCtfJ8KVjrhX+J6OiYI2KvdVdUwn1+BSjCHJisv8Zc/UuYqdTnBwYfCowXEU4fuA5o
         fQWlC0x43Lw2vGrcZjohE4mR/0bTy1D7K2FtD5Ji2ckVuqB/748Uq8wl2YGVxW66k2uM
         UWVcapTluCjqSkBJGxoHefhA8vtEWcnnqQxBk6NnXYalpp4bL5/46MXB7xGAEG+BZyx8
         zSJdNdeVzaFPEkrcTpyRCB1f4U3VcLIkfsqn5M7A83+nIJBFduH4VuX98dYjy0Tabvf+
         /bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bTYehEJibc5NpezL2miOM2UdvHHV5lxW3CvlvcvUFZc=;
        b=DaYNojXtZ2KKItaj0Sz+p9TRebhDp8ZfZsn8LoDKyRM2Yl6soKLuAOU/RlKG+anQRJ
         HADikK8ASOuKozsdBuxUenFrsMS1IW+Y2HASqg3kmpM2VhidophTzKzsVhrGHB0ECo6d
         DcXY3YiAAUDm3Gjklj9EpUmdtyCUqhRizr3PBzWX5ItjKWNqYzwAuTzXKiH/lCyrlr7H
         IWt8HXXTJzLvbIB+qMNd+arRI/QsDWOadRh0TKYpGZQqae+UP1Nk48d1kz5TbpzDCaqv
         Iks+PRlaR2eu0pD8jTHnhBvRb9WrNSTz8lB6G5m4Cj/ftFQICWBTbmysQYjzsdjSX/+B
         WvvA==
X-Gm-Message-State: ANhLgQ0NepTn2fjlDZQZjPulT6Hs0G1NHJHRikP7EwKwRtfxdqDsz9bv
        Y5kTT2CB3/mjPtx84N3nRgzlLFnB
X-Google-Smtp-Source: ADFU+vs8+HuLZBtQ3iKO2QQDWy8WQ1tzX+o4NRgABRPSTDnj27IhTo6J75JWGFZDWwYDHYbxmJVT4w==
X-Received: by 2002:a5d:4284:: with SMTP id k4mr13569324wrq.310.1585559295971;
        Mon, 30 Mar 2020 02:08:15 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id z1sm9323400wrp.90.2020.03.30.02.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 02:08:15 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2)
 syscall
To:     Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>
References: <20200202151907.23587-1-cyphar@cyphar.com>
 <20200202151907.23587-3-cyphar@cyphar.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <4dcea613-60b8-a8af-9688-be93858ab652@gmail.com>
Date:   Mon, 30 Mar 2020 11:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200202151907.23587-3-cyphar@cyphar.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Aleksa,

On 2/2/20 4:19 PM, Aleksa Sarai wrote:
> Rather than trying to merge the new syscall documentation into open.2
> (which would probably result in the man-page being incomprehensible),
> instead the new syscall gets its own dedicated page with links between
> open(2) and openat2(2) to avoid duplicating information such as the list
> of O_* flags or common errors.
> 
> In addition to describing all of the key flags, information about the
> extensibility design is provided so that users can better understand why
> they need to pass sizeof(struct open_how) and how their programs will
> work across kernels. After some discussions with David Laight, I also
> included explicit instructions to zero the structure to avoid issues
> when recompiling with new headers.>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

I'm just editing this page, and have a question on one piece.

> +Unlike
> +.BR openat (2),
> +it is an error to provide
> +.BR openat2 ()
> +with a
> +.I mode
> +which contains bits other than
> +.IR 0777 ,

This piece appears not to be true, both from my reading of the
source code, and from testing (i.e., I wrote a a small program that
successfully called openat2() and created a file that had the
set-UID, set-GID, and sticky bits set).

Is this a bug in the implementation or a bug in the manual page text?

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
