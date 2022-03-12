Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E614D6D70
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 09:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiCLIE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 03:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiCLIER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 03:04:17 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B92A4B1D1
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Mar 2022 00:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647072192; x=1678608192;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vWrO9cyYr6q0oBQodYPW0B4WRkzjdaFDLBb6mE58NYw=;
  b=OKGKIsfD89NuYZavEJONY3V8W8RveDmcsaP1KBavbDEl8wRM9U21ZZ69
   JwAQl8FkX5K8vlzoAlvN87r7xgaseXXtjmztvP4DMkmvfrJEHbvM6RQ9N
   Q/bcc8WrxR+JV8ceMDmf/L/w5lno/vobl7+LYDtbnZOWhQxJaDW+l5YFM
   bl/zHj6guc2iyWLRjOQh2uwnLj/X+zS2mh9ydU/bGz86L0DIBjcsixVdV
   iW3J0SvHi9/mLAZ6FD7ZS8vKdhDzT9McDGeausOai4FgniBg2j9UQVWD4
   zIcoizjO7pnuy6ZqRPFDFks+l9f2SXmOKuEtP5Nk1+bK1bvdM7ILXLJZ/
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,175,1643644800"; 
   d="scan'208";a="195172692"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2022 16:03:08 +0800
IronPort-SDR: ug89Eksl5Iv6/s00UOejg5RQCXyGMxtjf6o/9VKwqWI8WO9p/OLC/TR0Rf592d0R3y+kBnplkm
 WkAXs79xiDOZ/7umdkRdeeDgbTKzIlu68L0KjtvIIse0H2LQU0d82zVVlVFrwDXTBlkU6rvV60
 /s2rozKi8sgenYeEFdX9WfMqyNvSgZgO0njeV7Y3G1wVPhtAaCrnuvvUirzFuhe4uMBO7wU9OV
 KOigue5edP/KnIo19NzWVzn4r0KXPE6mQqq0ym8scoEwB6EVGqSjT2U2o3XpZ18XtAWa7ihPJ8
 XYzkvMOJcOPFNayU1xU4B4E8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 23:35:19 -0800
IronPort-SDR: 99nG1eAdf+j5CUdYwJCjX8dVuIK58EzCfZG5pLc26ImbQNbaM7/ZfSOi+ZS++6Q47fXJDNvM2T
 eneLDjgycj1rHOp+aC6rD2Gzb+3PIzJlhOzE2IdIEjdvRVU82hrX1wLoJNS5Lcyr+IukqEZlXt
 ku8ZM9/QVz5YnYUZ16fBKNpFnkxyqta3KpKMxRPsGtWEneEMuQnVapj5Nu/XmzIEolPIiDfvin
 6vJkyhvwdvbYuBF/zACowVLC8MOrsFFyYvGshJd9SkP2awuRF5q28tbRNwVrVUHNZ+pyl5vFmb
 2hQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 00:03:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KFwK82C3Qz1SVp8
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Mar 2022 00:03:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647072187; x=1649664188; bh=vWrO9cyYr6q0oBQodYPW0B4WRkzjdaFDLBb
        6mE58NYw=; b=hGDU8jKiPwONNjSz4o/NXS8gNMXzdTwkjB9gYHqv46DPfepYaUX
        TJX7GVTvZVfAg0pOqy2Fa4wDSH2yZKFGQ0zHkB3/EbVRSWbb5C7CJ1/IiYp+xJF3
        YKcWkc0IzZOAnL0qNqB3sS0maNzQ2UrA8IZ9/hNsrsgXHUVXRp3DyYrtvmJvKKNz
        Cd90uaPRXJRfkjUnTBh2vRVTMmoViRCP9Td+WfdVcQtdt9v/8DcgTQmCb4cpO3pl
        kXTvNOB/G8wurSU6lKJwI3mKTkqOJaHGq7N8YFM5GgdpygE1qbUlp1mcLPKd9Fw3
        1DXAChPQy5b22hkCOyDi3x2Kuuj8fdFm3Kw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IH_KcO0iOGA5 for <linux-fsdevel@vger.kernel.org>;
        Sat, 12 Mar 2022 00:03:07 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KFwK42RnNz1Rvlx;
        Sat, 12 Mar 2022 00:03:04 -0800 (PST)
Message-ID: <1d3f56c0-3f53-3609-d376-1a5ffc327bd1@opensource.wdc.com>
Date:   Sat, 12 Mar 2022 17:03:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
 <DD05D9B0-195F-49EF-80DA-1AA0E4FA281F@javigon.com>
 <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
 <8f8255c3-5fa8-310b-9925-1e4e8b105547@opensource.wdc.com>
 <20220311072101.k52rkmsnecolsoel@ArmHalley.localdomain>
 <61c1b49c-cd34-614a-876a-29b796e4ff0d@opensource.wdc.com>
 <Yir9a8HusXWApk5l@infradead.org>
 <20220311075317.fjn3mj25dpicnpgi@ArmHalley.local>
 <YisMUruNKNlV8FhW@infradead.org>
 <20220311085925.c66kly5zy6otgcer@ArmHalley.local>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220311085925.c66kly5zy6otgcer@ArmHalley.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/11/22 17:59, Javier Gonz=C3=A1lez wrote:
> On 11.03.2022 00:46, Christoph Hellwig wrote:
>> On Fri, Mar 11, 2022 at 08:53:17AM +0100, Javier Gonz=C3=A1lez wrote:
>>> How do you propose we meed the request from Damien to support _all_
>>> existing users if we remove the PO2 constraint from the block layer?
>>
>> By actually making the users support it.  Not by adding crap to
>> block drivers to pretend that they are exposing something totally
>> different than what they actually are.
>=20
> Ok. Is it reasonable for you that we start removing the PO2 check in th=
e
> block layer and then add btrfs support? This will mean that some
> applications that assume PO2 will not work.
>=20
> 	Damien: Are you OK with this?

See my answer to Luis's email.

>=20
> We can then work on other parts as needed (e.g., ZoneFS)


--=20
Damien Le Moal
Western Digital Research
