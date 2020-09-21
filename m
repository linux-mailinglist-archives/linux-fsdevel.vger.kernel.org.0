Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20378272BB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgIUQV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgIUQV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:21:27 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E069CC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 09:21:26 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id a3so17631658oib.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wI5WECW0V/pdVKWU3V9XtntLhgWS6VZJW663ltNPIoM=;
        b=BmYjZCCNi1HZT8atB5/9bV4/skAqiQhNQ6A65vrYQJ5f+sqPavPUzc1ZWJYOt85brG
         IXM+w0oK0pyMwqqKjB25NQ0YK5PbcooPgq++/KDb03hSUgTVUHLV9R3GOp1uwXGcUw1I
         f+wwMfwSZFKXkAStIuvzAK2KOjDSlEgVX88PYsr6XN5KIXnih4MxxprZCpc+xi8XoCK8
         NR55rWc7hobt51+nh2M8IOIKQ4/4km4oRxMqJhrGJNUOSG9326SeEqf8dLLGk4X4hbqS
         nQFnpdm0StYFuO4Nqh+AmrONYZXITu5a7H1TBLafqv+M/2pvdDu0GwFMdlUwULc8gTKs
         QJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wI5WECW0V/pdVKWU3V9XtntLhgWS6VZJW663ltNPIoM=;
        b=jqTZjSRbjmHCyfag0VW3xg548SNJgrRqoGfJie22qbWgac5QEl4qx80KYKauV8E9yJ
         /2W/1xDhcvq3RPHfKJn01+J2i+l+lsZuBA5rfSMA2feW+GmBxqhhBBbPCTHw5fTVuO4J
         dGarepzcrX2p7eiD+sDHwvC/8Ng41YKo/H0gyO1kMQ0SBFK0At+k52cxdEJtvExsQqMc
         Wm8fRV7o0Pq83deP84Epap3Pt5gVO8qE/1z/uAg1HQWwnyFgUbbdEw7I+fJ6cqd3OtAD
         NfhQjmMGm6SE1zOuef8KSD+hY2XzAWg/4yrFsbSVo9eq9DhmFB5ekxixmAtRw1w/OnpJ
         hAgw==
X-Gm-Message-State: AOAM5338+rWWpOQsqaIvN2y/+npQIBZlLvNOg2d3Qv1bjtXxrYpZgJX7
        fe2h25smGT4DhrdyOExAMfOXog==
X-Google-Smtp-Source: ABdhPJyfoh/O7y19KEqeQG48cwxjNqIVd+6lXkmkRv6V3n58byFEw0G0IkGrYFGQwOQG4hP1NwzHUw==
X-Received: by 2002:aca:f414:: with SMTP id s20mr122296oih.42.1600705286091;
        Mon, 21 Sep 2020 09:21:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:42f0:6600:5825:d30d:b44a:2b1f? ([2600:1700:42f0:6600:5825:d30d:b44a:2b1f])
        by smtp.gmail.com with ESMTPSA id x21sm6797059oie.49.2020.09.21.09.21.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 09:21:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] hfsplus: Avoid truncating the logical block size
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <1600650462-41862-1-git-send-email-wang.yi59@zte.com.cn>
Date:   Mon, 21 Sep 2020 09:21:23 -0700
Cc:     arnd@arndb.de, ernesto.mnd.fernandez@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <259C2036-40DA-4441-9740-07C7AB4CFF54@dubeyko.com>
References: <1600650462-41862-1-git-send-email-wang.yi59@zte.com.cn>
To:     Yi Wang <wang.yi59@zte.com.cn>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 20, 2020, at 6:07 PM, Yi Wang <wang.yi59@zte.com.cn> wrote:
>=20
> From: Liao Pingfang <liao.pingfang@zte.com.cn>=20
>=20
> Return type of bdev_logical_blfsock_size() got changed from unsigned
> short to unsigned int, but it was forgotten to update =
hfsplus_min_io_size()
> to use the new type. Fix it by calling max_t with new type and =
returning
> new type as well.
>=20
> Fixes: ad6bf88a6c19 ("block: fix an integer overflow in logical block =
size")
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>=20
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>=20
> ---
>  fs/hfsplus/hfsplus_fs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 3b03fff..3ed36d8 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -302,9 +302,9 @@ struct hfsplus_readdir_data {
>  /*
>   * Find minimum acceptible I/O size for an hfsplus sb.
>   */
> -static inline unsigned short hfsplus_min_io_size(struct super_block =
*sb)
> +static inline unsigned int hfsplus_min_io_size(struct super_block =
*sb)
>  {
> -    return max_t(unsigned short, bdev_logical_block_size(sb->s_bdev),
> +    return max_t(unsigned int, bdev_logical_block_size(sb->s_bdev),
>               HFSPLUS_SECTOR_SIZE);
>  }
>  =20

Looks good. Thanks.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>


> -- =20
> 1.8.3.1

