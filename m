Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C856192BFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 16:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgCYPNj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 11:13:39 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15838 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbgCYPNj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:13:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7b74f50001>; Wed, 25 Mar 2020 08:12:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 25 Mar 2020 08:13:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 25 Mar 2020 08:13:38 -0700
Received: from [10.25.72.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Mar
 2020 15:13:35 +0000
Subject: Re: mmotm 2020-03-23-21-29 uploaded
 (pci/controller/dwc/pcie-tegra194.c)
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        <lorenzo.pieralisi@arm.com>
CC:     <akpm@linux-foundation.org>, <broonie@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-next@vger.kernel.org>,
        <mhocko@suse.cz>, <mm-commits@vger.kernel.org>,
        <sfr@canb.auug.org.au>, linux-pci <linux-pci@vger.kernel.org>
References: <20200324161851.GA2300@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <eb101f02-c893-e16e-0f3f-151aac223205@nvidia.com>
Date:   Wed, 25 Mar 2020 20:43:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324161851.GA2300@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585149173; bh=FZyl6tl5d7IEm26Ng+7VPnCh/JccA87CapxQqKQR9tc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fXyrjsGyuSQ1tWKq9YQIqmt3R467Bj3K8rop3N18qliTqERdmmEOnNPiZBglPolG2
         VFNLTI3mKMoAKLF2Bx/dXoELB+hPV4guoy0pNa5O6HnJcWp2ngixLC9iKryoLBl2uy
         48Ql3FZHcNcbj3Qc8hD/tNnVNlZw1rCGuOEYOItXISRWle7+DPSeEP2iQuHJwMkuVU
         ywvOeQY306cgHCqnUoh+UvcuwY8GPs88vyGMxL+EmSxm/+Dzs2Q+xVmyUBM2PAQYed
         CEtljRX1vRmytGIV4ulziisdkzVXXFYMphmpsWY1oTPJe+lMnW08SrcIIlwjC9HIBO
         EknC0nM8GyVpA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/24/2020 9:48 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, Mar 24, 2020 at 08:16:34AM -0700, Randy Dunlap wrote:
>> On 3/23/20 9:30 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2020-03-23-21-29 has been uploaded to
>>>
>>>     http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>> You will need quilt to apply these patches to the latest Linus release =
(5.x
>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated=
 in
>>> http://ozlabs.org/~akpm/mmotm/series
>>
>>
>> on x86_64:
>>
>> ../drivers/pci/controller/dwc/pcie-tegra194.c: In function =E2=80=98tegr=
a_pcie_dw_parse_dt=E2=80=99:
>> ../drivers/pci/controller/dwc/pcie-tegra194.c:1160:24: error: implicit d=
eclaration of function =E2=80=98devm_gpiod_get=E2=80=99; did you mean =E2=
=80=98devm_phy_get=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>>    pcie->pex_rst_gpiod =3D devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
>>                          ^~~~~~~~~~~~~~
>>                          devm_phy_get
>=20
> Thanks a lot for the report!
>=20
> This was found on mmotm, but I updated my -next branch with Lorenzo's
> latest pci/endpoint branch (current head 775d9e68f470) and reproduced
> this build failure with the .config you attached.
>=20
> I dropped that branch from my -next branch for now and pushed it.
I found that one header file inclusion is missing.
The following patch fixes it.
Also, I wanted to know how can I catch this locally? i.e. How can I=20
generate the config file attached by Randy locally so that I can get the=20
source ready without these kind of issues?

Bjorn/Lorenzo, would you be able to apply below change in your trees or=20
do I need to send a patch for this?

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c=20
b/drivers/pci/controller/dwc/pcie-tegra194.c
index 97d3f3db1020..eeeca18892c6 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -11,6 +11,7 @@
  #include <linux/debugfs.h>
  #include <linux/delay.h>
  #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
  #include <linux/interrupt.h>
  #include <linux/iopoll.h>
  #include <linux/kernel.h>


>=20
> Bjorn
>=20
