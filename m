Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA31663467
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 23:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbjAIWxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 17:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbjAIWx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:53:27 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C082915829
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 14:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673304806; x=1704840806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8lULQIfDtrtvZPqCa5t7Bk3Bz+3ujRf+1RJ9B+I6Osc=;
  b=jN8DkxT9HCQg/E1HpDxD1g6nAjAlYED5vjDHMWgvq546dvN7OJ2UBluh
   K8VO2eY95axmehLIFgJnRgu7KWZzIAUm6aysCRdByrVJfJszNk1MGHpJq
   lI29Wk0JpsCOsMudCyXn6h74Fi7X5+LgevUp7As0eed/iHB+xU4t7SsVl
   deXVKptBdlb5J9h5rL6X8wH1T0QGelW3tigND117Ufx9D4JHrZE02U955
   EifKecPcXERx5F7+N5vZDw2iWlpXppgaHCZEuSHfVRxbsXk8pVkeiE9Dl
   qV/dB/p/KbgmGl5JDvojMyJflr9mQJYw3iGLOgVcRHS7LTi/s1lJD8itH
   g==;
X-IronPort-AV: E=Sophos;i="5.96,313,1665417600"; 
   d="scan'208";a="332392933"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 06:53:22 +0800
IronPort-SDR: vsYjVPcjm4R6RBjEndqB6wTpkY6bXiXY2j4ga9GMBTr5hk1YfNBTJXI9yVuzJZBWeqHqIWp3mF
 9qyhbnP++Pnt9M7j/a/i6DqNeahikMIgdccapPEAZFqApAiER39XI8wM+103w0gBwevh/MOgKy
 MT6+ZiSoC01T9OmIDd9udwF0LON6WKgiJGpxLQxeTZg5A8C3LuYO4NczFi2G6kRYLO43agIZDi
 /BvWeTNNs6W5OWZmZDPhAFGTDEH5E26ivXbjyCse+ccQCmcKvOgJZAw2xYhaFXq5oLyRZXkKW6
 fac=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 14:05:28 -0800
IronPort-SDR: RX/0v4heE5nWbKBeTbmiNRVVs0CE/akkot2Lqf/6Ke+mAgscwggW85EoSek9gL8IGI/2uG7KLt
 3334i42W5b4tYZNIi1K4bzhF1ySWVA0A0E0wxvsZN1uK9Zp+oil3ofaoCOZAoUzA470P3m3l2W
 NlhSwzn2oI8VV0jZNQIcXrPJAWNF3ZnAnO+oPZKaptBPkszlO6jXghyf0/07ERz19sylkeUDDV
 OnnFOOgbpjizFUbvgbAn3jsmC19jLT8yDZWI69ojLAGo2pCJ86YIRccgtYZBRySGXOz9wo0J9/
 3Fw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 14:53:22 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrTkV15sMz1Rwtl
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 14:53:22 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673304801; x=1675896802; bh=8lULQIfDtrtvZPqCa5t7Bk3Bz+3ujRf+1RJ
        9B+I6Osc=; b=mhWRWlWCxKCdyXj89wWEFb74vNajZueQXIyeWLwixoHvmVTyuSr
        mm+ndGNWxus1LZcbcuxzusPCcjF5BZsmvj/2zhBbZ2U6xNbeSrNWzRMKQ+3sOFBl
        Rno6KED0tAZ1qXjkfuN6axynaaFBlUpM3WbjeFrZUALotEWABojJZ2sEzmvG09fz
        SYsIEaQZN57dsDvylCQzJqNkkLHkEYsH6dRhJ7DfTRTo1i3iXkoA0C9Wc0Xy73OR
        u37oWfNwkW6pkfH6poFFmFe1ScNB+St+hmh0NHYcPxLeKNtbxm0nQJkcd6yMFoaF
        MSbmDtcl6LYODxw0OqhzwQmPxWdENOPe5Hw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QF_y_Yj5t00u for <linux-fsdevel@vger.kernel.org>;
        Mon,  9 Jan 2023 14:53:21 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrTkR1gRlz1RvLy;
        Mon,  9 Jan 2023 14:53:19 -0800 (PST)
Message-ID: <04cc803e-0246-bf8a-c083-f556a373ae4f@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 07:53:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
Content-Language: en-US
To:     "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        lsf-pc@lists.linux-foundation.org
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
 <CGME20230107015641eucas1p13c2b37b5ca7a5b64eb520b79316d5186@eucas1p1.samsung.com>
 <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
 <20230109153315.waqfokse4srv6xlz@mpHalley-2.localdomain>
 <AF3750AD-1B66-4F8A-936F-A14EC17DAC16@bytedance.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <AF3750AD-1B66-4F8A-936F-A14EC17DAC16@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/10/23 04:11, Viacheslav A.Dubeyko wrote:
>=20
>> On Jan 9, 2023, at 7:33 AM, Javier Gonz=C3=A1lez <javier.gonz@samsung.=
com> wrote:
>>
>=20
> <skipped>
>=20
>>>>
>>>> (1) I am going to share SSDFS patchset soon. And topic is:
>>>> SSDFS + ZNS SSD: deterministic architecture decreasing TCO cost of d=
ata infrastructure.
>>
>>
>> Would be good to see the patches before LSF/MM/BPF.
>>
>=20
> I am making code cleanup now. I am expecting to share patches in two we=
eks.
>=20
>> I saw your talk at Plumbers. Do you think you have more data to share
>> too? Maybe even a comparisson with btrfs in terms of WAF and Space Amp=
?
>>
>=20
> I am working to share more data. So, I should have more details.
> I have data for btrfs already. Do you mean that you would like to see c=
omparison
> btrfs + compression vs. ssdfs? By the way, I am using my own methodolog=
y
> to estimate WAF and space amplification. What methodology do you have i=
n mind?
> Maybe, I could improve mine. :)
>=20
> <skipped>
>=20
>>>>
>>>
>>> I think we can consider such discussions:
>>> (1) I assume that we still need to discuss PO2 zone sizes?
>>
>> For this discussion to move forward, we need users rather than vendors
>> talking about the need. If someone is willing to drive this discussion=
,
>> then it makes sense. I do not believe we will make progress otherwise.
>>
>=20
> As part of ByteDance, I am on user side now. :) So, let me have some in=
ternal
> discussion and to summarize vision(s) on our side. I believe that, mayb=
e, it makes
> sense to summarize a list of pros and cons and to have something like a=
nalysis or
> brainstorming here.
>=20
> <skipped>
>=20
>>
>>> (4) New ZNS standard features that we need to support on block layer =
+ FS levels?
>>
>> Do you have any concrete examples in mind?
>>
>=20
> My point here that we could summarize:
> (1) what features already implemented and supported,
> (2) what features are under implementation and what is progress,
> (3) what features need to be implemented yet.
>=20
> Have we implemented everything already? :)

Standards are full of features that are not useful in a general purpose
system. So we likely never will implement everything. We never did for
SCSI and ATA and never will either.

>=20
>>> (5) ZNS drive emulation + additional testing features?
>>
>> Is this QEMU alone or do you have other ideas in mind?
>>
>=20
> My point is the same here. Let=E2=80=99s summarize how reasonably good =
is emulation now.
> Do we need to support the emulation of any additional features?
> And we can talk not only about QEMU.
>=20
> Thanks,
> Slava.
> =20

--=20
Damien Le Moal
Western Digital Research

