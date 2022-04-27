Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828B651250A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 00:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiD0WJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 18:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbiD0WIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:08:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C74CFCF
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 15:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651097134; x=1682633134;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ltiub3iDq6D6Wb7M/70Y0VAAaW3D7ZlOojkFrPEHoeo=;
  b=rQN33bbc8FRqFpZOY6ECNWeBcSkJLFkpuRzsBUp8y0u0xQxlsi5by/Mt
   Jsm5oS6HMPzujIX6WnHp8Wu+DG9mZQ1FARDZ2p1lnRywawjWIz75WHqtz
   cZGb+p196M02fCEmyUg+gMHwYBVOXO24ozWhtpR2hMSbERpl1AhsJaT2z
   cp5wpcUUwJNOpbQbT/C2wGZW1U7nw8im7jcsEs9F1E4MjLDOpYJokOXi8
   fv5Bk56igMxLHv2nBMrWOlp2p0bowEaS+21lYGacYn/vq0puizgDuW58F
   N8ejwATsPbOLnTtyHFJpZUbhlc6GHBtE1d4bZNAe/9zECKxQRTeqYEFWS
   w==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; 
   d="scan'208";a="198996975"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 06:05:34 +0800
IronPort-SDR: jMdVkOgKUIVOM8rtj7n9OGIIvEXH6QG1hiPy2pA6FZ4HBli3/d8LsDRUIjLNll9ScLwVebz9MO
 dGq3jtVVaCMzYf7aayWXFZTdMgKO7jR8NzHSCCWn+j0XTyTP286Sgtm72yllrpim/SDLCxIYmr
 nkmM2KleQdWpJ+qDmO2gETciKDoRNrRNfj9MOWRQu9AykXF0woMb0QRZFBetONnzeFYlsbt8Mx
 sZd3Qyk8KkDAKUQcRb+ZuXhwGq861NL3nDPQFLcgy/X9K+id3wQbyANJ1MqwHgEfV208K2cylp
 8ekU6YNDOM0Pf4Vp4AwQNzf9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 14:36:26 -0700
IronPort-SDR: lrytTbeEBKqTlmBe6a54SyMzqgpgBmGOThA86J5wTc00ikCEeU9c01o2bGWOhz2q3gkgS0Htlg
 Thu9F8q2wlLiVrvJs7qSjVPI/z/701e8OzBxhD8gQK7OKwXUDJCOBnZPlyp46R60yecGCKMvmX
 gHjgbBoEfeKpqV22XkUZONz9GbYG9/kWckFFysf3cFyvFqcyr8kD6MNnIaXj63tIAqikNwua6h
 lEavcJJNSigNVsYNHY34yPQmghGKif4izsNOG4DM6g0nlinpaMk0wvFAvE8Xk3KyQcjbw3aSJl
 PZg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 15:05:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpXqy5l2Gz1Rwrw
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 15:05:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651097134; x=1653689135; bh=Ltiub3iDq6D6Wb7M/70Y0VAAaW3D7ZlOojk
        FrPEHoeo=; b=tf10gyOH0lx9kTAQMvmNEOqbTNS9DLTOZB9qsNe71qSj+MlslLY
        F2EMsRT1hYv8Uex+f8eyJX1V+hNKxnq0ZvLAwm2N9h1bKDM2qAdaXd8XFxq2OFtZ
        V4RlBXCG//INUr7wVIQqFsb2qymtVwVHXuxY8eD6UpYIYKBOcpCxEpfLcPWyOf+Z
        a1goiEri2UoD+WOlXIFCHSZYAnDDnYTLxwQ44EG/xQ6NBuYZ4KdX6hPN8R/IC8+K
        mjJuGAhmLtYWSzjRHY0sOUl5Yj3top3PIke6IkXYtsIwx8o7NXzckBhJqqv2uDvr
        xwDwWqUps86ht4CXLQyUclRDU1FKcwhVZrQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5_yoig8E3Ci6 for <linux-fsdevel@vger.kernel.org>;
        Wed, 27 Apr 2022 15:05:34 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpXqx1gFtz1Rvlc;
        Wed, 27 Apr 2022 15:05:33 -0700 (PDT)
Message-ID: <c285f0da-ab1d-2b24-e5a4-21193ef93155@opensource.wdc.com>
Date:   Thu, 28 Apr 2022 07:05:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427124951.GA9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/22 21:49, Nitesh Shetty wrote:
> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>> The patch series covers the points discussed in November 2021 virtual=
 call
>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>> We have covered the Initial agreed requirements in this patchset.
>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>> implementation.
>>>
>>> Overall series supports =E2=80=93
>>>
>>> 1. Driver
>>> - NVMe Copy command (single NS), including support in nvme-target (fo=
r
>>>     block and file backend)
>>
>> It would also be nice to have copy offload emulation in null_blk for t=
esting.
>>
>=20
> We can plan this in next phase of copy support, once this series settle=
s down.

So how can people test your series ? Not a lot of drives out there with
copy support.

>=20
> --
> Nitesh Shetty
>=20
>=20


--=20
Damien Le Moal
Western Digital Research
