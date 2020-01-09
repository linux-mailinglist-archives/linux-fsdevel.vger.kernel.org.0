Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3496D1359A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 13:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgAIM7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 07:59:25 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:50317 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgAIM7Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578574764; x=1610110764;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wf1Fg2sCoJ4Mlv3XgjiWmlGNpwmS7N7TM5jzYc9wLSk=;
  b=DBTWrM6XJRUxRnuB6frjRY5D4xoxQghwj9IePMi8vyybPZjOgzTDEfLE
   9jJdC21e0L7iLcldHCXjrm8hOG4AP8a924MRZh8trCNIwejTF4zqAI+Fe
   1OYKN6kN+/hiyIyFkJXYzaEgn9Xnp9ItXnJE2/KYCyj3pBaJ+ZOD7wrE3
   5M3k4JBJhFBWYHxY3t2NqtChYN49FgrnZtRSlsDliFFZby+D+VVyCVhzL
   tFGWA8Q1SFwOhPnZ2lc1aZ+FKZpBamDIRyY85ac7qL9i0C8sAcn/W2DSP
   3myV3Wz1rg33F4swUFAGeHa2wlBlrPTftFHIn1Diwf95YaHIhIrru8Er6
   g==;
IronPort-SDR: XQoapWDfRtD7g5b1MQth8iN1PEJhEspFZBbgdG/fGwOACn6hX3IyAmc5oRicPTyKSdRgq4NkUP
 WXQSfns7xNpQf4dzZIkBuM3We59RlvAk/Tq7qLmF5yXdCowQjDavo1N0jRkc06Qj2gbPL3i/Ox
 FqUKdC3kJpM82lcjVU9xffBRy9mbItil7/ybcF5g13j6pg86QPgY2mDHpvmm12glMej62tMKIc
 Qsp0+yNPHa+vprd4wxZseRFWwrdbMyFgxRwBnllClN1eRHgmVZ7yD8ERC9LVC3Ba0H1vO025Ie
 Clg=
X-IronPort-AV: E=Sophos;i="5.69,413,1571673600"; 
   d="scan'208";a="127777408"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 20:59:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNrf4yBhqMqn+tLmVo5syHXZNbn8TTHkbQSzX5uDZMsbq7WfT1rZ0ENFD0a0WIywfJrvnoJaN6pzzH1SX9mEZoDmFvUK7E1R/KrtXrBXziiouy4L1MS+k1Xu0Czv6kga2D6nsH1PvKdd2m//W6RcomgwWjBdZ0VpSQPvfKG7o6pooPLED1YZhAZ7DviZi42lP2BNqySHidELzagoe3qCV0PfsJukMnE1yM91VGyHNwV9yDWkgV7oCaWok0Lyq6MVuwH5arT8wpoZkexRZohNNm3SgENxH6Ex3D4E+d8oQn1dlZ8SIuFfdq+z2iz58i57xOhBkEd2A/N9FvSjxGPpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDl0w8nt+ChFpGd/dTvZFcsVVUFi2d7Plw7MCQ4qPB4=;
 b=E2Wx994gFoyZ3+cLjUiT2fF8M10V34GeX2Izajz6ewaMMombFoTxShQkSec2V7+rVOn+hKDhy11S7xXPxM3VFfWZkAxbfHW4eniGS3CY51PnaAaZpPDjcx7kbQ0n/eTW6wESB3+DlWRjwcpAajq8wvHxxKZXTkOMUxrjgZgqo6VRkeSUBgN+DWMBo6IlPXHUzFeH4A+LCzNQtnp7fHvCZRD3tl2ReguSCROndrNZzKOtUaUk/a1ENm3FYRskCI+VgCJkNZm6rCLngHwYNejmAiOBRiUz3I0Z5P1b4dJT4Ek76CwMW5bQI9PH02FX3PCLTv/5m40q1SjXLaBvZgapjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDl0w8nt+ChFpGd/dTvZFcsVVUFi2d7Plw7MCQ4qPB4=;
 b=OOa9ig4gpY5dpBO5XemYdfUcvuntxlGD+ICNqZZ8BqFp7rLnSHn8iI3DfcLOTOkJvEqP6kJ1wMpRB2TUh0HNXJlaqXi6CE4pnPJ7rGoM04w8dNdYz4se+StzRnOGLXbxa3SJi0b+4iqNW95PDZKqgaFgkVGrHEKqL2uY0eUR55I=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4150.namprd04.prod.outlook.com (20.176.250.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 12:59:19 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 12:59:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hans Holmberg <hans@owltronix.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
CC:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Omar Sandoval <osandov@fb.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Thread-Index: AQHVr+qGZa1SvOsf40W81LFPPtqF+Q==
Date:   Thu, 9 Jan 2020 12:59:18 +0000
Message-ID: <BYAPR04MB58163E5A9D64C7367BFCEDC7E7390@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <BYAPR04MB5749B4DC50C43EE845A04612865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <BYAPR04MB5749EDD9E5928E769413B38086520@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CANr-nt0=C+1v=1MU6eNhX0-X4CEvc7D2UEF02oRMNHraQ1FRow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee4d92b8-684c-40d0-ffc9-08d79503bd4d
x-ms-traffictypediagnostic: BYAPR04MB4150:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB415015333536B5710D864283E7390@BYAPR04MB4150.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(78114003)(199004)(189003)(186003)(6506007)(54906003)(81156014)(76116006)(7696005)(26005)(64756008)(66556008)(66476007)(66946007)(6636002)(55016002)(9686003)(110136005)(316002)(2906002)(71200400001)(66446008)(53546011)(33656002)(5660300002)(7416002)(8676002)(966005)(4326008)(478600001)(91956017)(8936002)(86362001)(52536014)(81166006)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4150;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qSga9BkaKJ3vk+4BBZBiadLh4BFuoI7mI3H4QDVsrR9iN0jQWSyRnf4qBeixc90pEBm/YHgkf8g2Nr7+JlBaEI84NluvW1+xhdGTI+LVxex38U0KNsb1ULyX1jyjeHRYjKX6Kv539kefM3zPJeWRQAc9g/bdvIKUI2q6ugprnba9pilrNP+W1nJcpj0Z+yDDjJv92WEhVeitqIrItRhafFS2YVhd97xUYGQbVogzFy3q4rUO+HzUXYZPzcVnqldc2egt4kowd+Lxx5MvMgZUhXOBL1Y6GoV9SFGyf86Fv6NRPYZpeyOuNI/mib5NM4+DmDnxBUO4Zn5Jl+OqM56U6Z4YJ4CCHGWT43LFm7CEvD2zjO6mXKplDlVAB5PG6tg93wOo6egBNVXYNUWs0dZp4DgFGS2809nmizovP6SkkxzhX3WB07R28tmNuTOWa/p+ujCKqVm9owmlPkjPNVrXXPMydcB8cxOlDH5EoEEzEINObs8gZGMDLL5y5/7118EEmwdsA9oYwTQuMtOLxT+yEFvq5VexJIa6gBiCK0JsHAbqPWHViE5zGClma9CAlsj+/SmtHixpuzYnJijrJjnw3Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4d92b8-684c-40d0-ffc9-08d79503bd4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 12:59:18.8731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqk7HLIYvdtpBYc5lOkNbhHY0JqlzbkAI1yZJ52Kudwz/JK4uJMz4ov2sGeSUNusSu3ry7+M8Hcsl+aABDaxEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4150
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/01/09 19:19, Hans Holmberg wrote:=0A=
> On Thu, Dec 19, 2019 at 6:50 AM Chaitanya Kulkarni=0A=
> <Chaitanya.Kulkarni@wdc.com> wrote:=0A=
>>=0A=
>> Adding Damien to this thread.=0A=
>> On 12/10/2019 10:17 PM, Chaitanya Kulkarni wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>> * Background:-=0A=
>>> -----------------------------------------------------------------------=
=0A=
>>>=0A=
>>> Linux Kernel Block layer now supports new Zone Management operations=0A=
>>> (REQ_OP_ZONE_[OPEN/CLOSE/FINISH] [1]).=0A=
>>>=0A=
>>> These operations are added mainly to support NVMe Zoned Namespces=0A=
>>> (ZNS) [2]. We are adding support for ZNS in Linux Kernel Block layer,=
=0A=
>>> user-space tools (sys-utils/nvme-cli), NVMe driver, File Systems,=0A=
>>> Device-mapper in order to support these devices in the field.=0A=
>>>=0A=
>>> Over the years Linux kernel block layer tracing infrastructure=0A=
>>> has proven to be not only extremely useful but essential for:-=0A=
>>>=0A=
>>> 1. Debugging the problems in the development of kernel block drivers.=
=0A=
>>> 2. Solving the issues at the customer sites.=0A=
>>> 3. Speeding up the development for the file system developers.=0A=
>>> 4. Finding the device-related issues on the fly without modifying=0A=
>>>      the kernel.=0A=
>>> 5. Building white box test-cases around the complex areas in the=0A=
>>>      linux-block layer.=0A=
>>>=0A=
>>> * Problem with block layer tracing infrastructure:-=0A=
>>> -----------------------------------------------------------------------=
=0A=
>>>=0A=
>>> If blktrace is such a great tool why we need this session for ?=0A=
>>>=0A=
>>> Existing blktrace infrastructure lacks the number of free bits that are=
=0A=
>>> available to track the new trace category. With the addition of new=0A=
>>> REQ_OP_ZONE_XXX we need more bits to expand the blktrace so that we can=
=0A=
>>> track more number of requests.=0A=
> =0A=
> In addition to tracing the zone operations, it would be greatly=0A=
> beneficial to add tracing(and blktrace support) for the reported zone=0A=
> states.=0A=
=0A=
That would require a *lot* of data (e.g. super large capacity SMR=0A=
drives) and a lot of addition to the hot path tracking write commands=0A=
and all zone commands. Also massive modifications of the error path for=0A=
that tracking to be correct, and that would need report zones itself. I=0A=
am really not for this.=0A=
=0A=
> I did something similar[5] for pblk and open channel chunk states, and=0A=
> that proved invaluable when figuring out whether the disk or pblk was=0A=
> broken.=0A=
> =0A=
> In pblk the reported chunk state transitions are traced along with the=0A=
> expected zone transitions (based on io and management commands=0A=
> submitted).=0A=
=0A=
pblk being a logically defined device, it likely has some form of=0A=
tracking of zone state, similarly to what dm-zoned does. So it may be=0A=
easier in that case. But for physical drives, the amount of code/changes=0A=
and the runtime overhead of this tracking would not be acceptable in my=0A=
opinion.=0A=
=0A=
I have debugged enough buggy SMR drives to know that blktrace is a great=0A=
help as is. Drive level debug features (fw logs etc) combined with=0A=
blktrace as-is can easily do the same.=0A=
=0A=
> =0A=
> [5] https://www.lkml.org/lkml/2018/8/29/457=0A=
> =0A=
> Thanks!=0A=
> Hans=0A=
> =0A=
>>>=0A=
>>> * Current state of the work:-=0A=
>>> -----------------------------------------------------------------------=
=0A=
>>>=0A=
>>> RFC implementations [3] has been posted with the addition of new IOCTLs=
=0A=
>>> which is far from the production so that it can provide a basis to get=
=0A=
>>> the discussion started.=0A=
>>>=0A=
>>> This RFC implementation provides:-=0A=
>>> 1. Extended bits to track new trace categories.=0A=
>>> 2. Support for tracing per trace priorities.=0A=
>>> 3. Support for priority mask.=0A=
>>> 4. New IOCTLs so that user-space tools can setup the extensions.=0A=
>>> 5. Ability to track the integrity fields.=0A=
>>> 6. blktrace and blkparse implementation which supports the above=0A=
>>>      mentioned features.=0A=
>>>=0A=
>>> Bart and Martin has suggested changes which I've incorporated in the RF=
C=0A=
>>> revisions.=0A=
>>>=0A=
>>> * What we will discuss in the proposed session ?=0A=
>>> -----------------------------------------------------------------------=
=0A=
>>>=0A=
>>> I'd like to propose a session for Storage track to go over the followin=
g=0A=
>>> discussion points:-=0A=
>>>=0A=
>>> 1. What is the right approach to move this work forward?=0A=
>>> 2. What are the other information bits we need to add which will help=
=0A=
>>>      kernel community to speed up the development and improve tracing?=
=0A=
>>> 3. What are the other tracepoints we need to add in the block layer=0A=
>>>      to improve the tracing?=0A=
>>> 4. What are device driver callbacks tracing we can add in the block=0A=
>>>      layer?=0A=
>>> 5. Since polling is becoming popular what are the new tracepoints=0A=
>>>      we need to improve debugging ?=0A=
>>>=0A=
>>>=0A=
>>> * Required Participants:-=0A=
>>> -----------------------------------------------------------------------=
=0A=
>>>=0A=
>>> I'd like to invite block layer, device drivers and file system=0A=
>>> developers to:-=0A=
>>>=0A=
>>> 1. Share their opinion on the topic.=0A=
>>> 2. Share their experience and any other issues with blktrace=0A=
>>>      infrastructure.=0A=
>>> 3. Uncover additional details that are missing from this proposal.=0A=
>>>=0A=
>>> Regards,=0A=
>>> Chaitanya=0A=
>>>=0A=
>>> References :-=0A=
>>>=0A=
>>> [1] https://www.spinics.net/lists/linux-block/msg46043.html=0A=
>>> [2] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-=0A=
>>> namespaces-zns-as-go-to-industry-technology/=0A=
>>> [3] https://www.spinics.net/lists/linux-btrace/msg01106.html=0A=
>>>       https://www.spinics.net/lists/linux-btrace/msg01002.html=0A=
>>>       https://www.spinics.net/lists/linux-btrace/msg01042.html=0A=
>>>       https://www.spinics.net/lists/linux-btrace/msg00880.html=0A=
>>>=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
