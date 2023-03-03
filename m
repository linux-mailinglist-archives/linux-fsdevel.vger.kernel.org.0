Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAA46AA019
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 20:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjCCT1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 14:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjCCT06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:26:58 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0251B553;
        Fri,  3 Mar 2023 11:26:56 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id F21B33200437;
        Fri,  3 Mar 2023 14:26:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 03 Mar 2023 14:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1677871614; x=1677958014; bh=cn8ZyhiM02WQ5IwSpSCmExINbOiY1FTRvSe
        WV7cmSm0=; b=N1RSAryTYZAwtcYjGBO6mhkVHeOTEdBk1FiWfo+yxtKeRXF4BWM
        Gup6AFOhZYSEIEQ0d3k350CjQNw6t1JE7sSyP292rNiqKk1km4cuQWgUgSIWYeeP
        fxxR8aNHrOk+9JM+Qd9J7SkPdzahDXjgIvSyAyYLGN2HdM3e44lUF2FLjroz1VG3
        ywUTkf7LzyS3gcrulzAkIszU83cpCRwZ9wnIe47w8ghHAAhIdTE5lgFeb7kH2v7y
        iK1fSsMXA7Abhp9WAXtCqYEWSVobCBt0yKNYzHbsDeUzz9WM1Q4muyyw5cAWDBwf
        GNm75WDHwJ9HdRnULxf9Zs5MuYgIDUVrv0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677871614; x=1677958014; bh=cn8ZyhiM02WQ5IwSpSCmExINbOiY1FTRvSe
        WV7cmSm0=; b=kmDNuG7CWiWstb8TFK+mqFGxbQzUJwdWbBE5EUQNE+j/3nLPQDN
        zkK7YlQESR5EMyn8bGovZT9uluSULGIIpJNLpsmlxK5e7jcNsa4qavsfFTxJUnhY
        VwnboR/cfEH/qHWxnyMywlQX5fjsuiQGs/sQq/Vaa6QU5xHwNyY5/Cb67ju0vwr/
        94kY2tI9nGDPcG5NuLEwqc1xvE3cyRkSorrYvGrFukgrXPHS013guFmZ0Zk5G/BO
        lxFoHsCxRMEbt2LzEVqsSXgnJm4N/Cc4oe3wQfJ8h83cNlJgjCak/FNO+wmwBpgu
        dmDFGy5S/pCUeApQ/bznYgazhzTGupR8AAA==
X-ME-Sender: <xms:_kkCZD8LsWhMk1VoC3ce8QG2624zNGxgi-jz-M7j5rbTkSUHdQFzow>
    <xme:_kkCZPt_huuq4-vlUmCvgMNzY89VYrTQTCz4r9PV5tzuNTPwRjAJCR3ruC3PHDhqQ
    RwM7-h9G9Fqbzd->
X-ME-Received: <xmr:_kkCZBBYBLzSmq7hVsHbhTW0OcGX6z8QQqqC_nSUGbtMCsbs3rhig0ZLKUxBIB3tJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeffhfdtvdeviedvudeuudejteffkeeklefg
    vdefgfeuffeifeejgfejffehtddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:_kkCZPdKm0iKnXzKoTEO74wQj1zBiJhb5oIYpJ1ztphhH5-zsoAKoQ>
    <xmx:_kkCZIOZcPnDcbhWy-U54IKul76IDA_tP2CU0JjDiAR3_cXx08eC3g>
    <xmx:_kkCZBmrh_58DWCT5-N4uL2M_-ig74T4b9o_XQZRma-nLoj9X1PUPw>
    <xmx:_kkCZJGSjHabyAMAs4yAhGa-0J4iIjczMfee864DGEUiasoDazEKAg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Mar 2023 14:26:52 -0500 (EST)
Message-ID: <381a19bb-d17e-b48b-8259-6287dbe170df@fastmail.fm>
Date:   Fri, 3 Mar 2023 20:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 7/9] fuse: add fuse device ioctl(FUSE_DEV_IOC_REINIT)
Content-Language: en-US
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        mszeredi@redhat.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <20230220193754.470330-8-aleksandr.mikhalitsyn@canonical.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230220193754.470330-8-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/20/23 20:37, Alexander Mikhalitsyn wrote:
> This ioctl aborts fuse connection and then reinitializes it,
> sends FUSE_INIT request to allow a new userspace daemon
> to pick up the fuse connection.
> 
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: StÃ©phane Graber <stgraber@ubuntu.com>
> Cc: Seth Forshee <sforshee@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: criu@openvz.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>   fs/fuse/dev.c             | 132 ++++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/fuse.h |   1 +
>   2 files changed, 133 insertions(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 737764c2295e..0f53ffd63957 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2187,6 +2187,112 @@ void fuse_abort_conn(struct fuse_conn *fc)
>   }
>   EXPORT_SYMBOL_GPL(fuse_abort_conn);
>   
> +static int fuse_reinit_conn(struct fuse_conn *fc)
> +{
> +	struct fuse_iqueue *fiq = &fc->iq;
> +	struct fuse_dev *fud;
> +	unsigned int i;
> +
> +	if (fc->conn_gen + 1 < fc->conn_gen)
> +		return -EOVERFLOW;
> +
> +	fuse_abort_conn(fc);
> +	fuse_wait_aborted(fc);

Shouldn't this also try to flush all data first?

