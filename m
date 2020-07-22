Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21802229AE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbgGVPAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 11:00:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22594 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgGVPAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595430052; x=1626966052;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0nxNOZj9vv445T+wehbcJEDixVyv8xm1eE2iL3UmXoU=;
  b=k/2kpzTS5IHLNFrJf7L8nSyPz6lPyROPyYDY2/c6wg7DyGMcr0+pGPm/
   xzOLQGdpZr1PLGmN+X0oDU6yKwwIc3/RaqJkPtbosyjwcrOURxmJQawjc
   EXt46osNTpBTRcnnENWWfs7BOsm7Xb13tvsDjZNGUU3J2CIXorQLK9zAo
   Yj+LlJYcJup/Hm6ODEmGhCM4b1Z5zYnI0qdEJ+xkVCEfySHREYC68ulzH
   z+nLytiQNe6kOuX3F7q8Ln9DYBcNbFNXo7zrwMhxi78daHCFvCiOnc0ib
   Z+ZycLbcquUBxoPkhwgCT/LYf7FFRPJ5Vz02GFnZqcmmGOtOCzXeMUypV
   A==;
IronPort-SDR: alYnd/4HM81ZgnIxhBH8nevKYFG+aG68eHQBHORyKMNfshd4kjQZ7/b2Z0iUfa2patj986iGfo
 aHZvimgcrXzNo4pE7VuFj+x6K9yoeVx2GxDRc8Mw7DE/GgI7sCGCSx2C5IG9mMBZQC8GR1RcNI
 oFebwBpxelvo0y20FVVSY4X6pJwWDeFXSe8gIwgknk6c01qVrIPtt6CwYlOM2kIkf0XMoeQksB
 aV+7QSD56b5bcDOItzuRibiSVs2Ns0uUKF02BoXUNu6gn5B9ioy79UO0wnVQ58zStw9eP8MOrm
 YcI=
X-IronPort-AV: E=Sophos;i="5.75,383,1589212800"; 
   d="scan'208";a="143119338"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 23:00:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCOJxDm9skRZvdSRr3v1VViBtOGVtSRLqfCeYSASXJxiz2rP+aPjF8aCO7/c5aY43prXpU3Ua3PCrtNcax5BkkZ5ZfX3p7vm+g69yHnSiVUPeJ62M4QCmBqUaJ0zBS4FCPRjGPfBpX5gt4b5TOvfXMGI/GU1hpHv/BNU2tJLn+VNADeuot8w36Z4+BTavrFXzO45o2Jo96yPnlffXH0mkQKrBZMeWJ8Hw9Y2gucIEUzTL0H0zncOwv/R768E8BykvIny8n5rlVIYlIYeE3NbaMgWQzcLtqRQLUatzoTKB2MVW6XWS5thCL2N6L5VRiOt0AHWqRwMsYzbLfZsrAvjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciArjebXqR9YKLxa0Zn+WusD9uecPiA2liAmodnzrkE=;
 b=LldVS+HjkZwWlTXH+VZib/cctwMw9QXKBSQhEvn59jVV/JIJLAgDWwDbTwH5Pu7WVh7JRpvS9BEHuIIqzb7LpUJcvthOjt6iouuC8OgN4dczQWjxFqVsIcB/gSkMNAplmkXJLEGZHkQTfzI2EVl03iZ2rh2d+hhmcH0yfu1lIieNIwbn9EZVZfvJkAtNClsk16OuxEoJ78PcgvKjtx/kOGaXrNqSvwyYcviBOZ3dPY/H8sStNr1H7/csVy5di9PHha44hCbhfhRKyILqy8bCOCdTq66Kv418cqk5tpjhTXS5tkXfhKjcu6D9vQO/RGKvymOqAUIgiAtbyiye5QHEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciArjebXqR9YKLxa0Zn+WusD9uecPiA2liAmodnzrkE=;
 b=q2n4SftBD4MiJRIhT1WSVsr1gUU7H3yMi25fTRxHoZD+pXqCw7QDcL5Al8M1l1R6dM9VcNODiITke3cE6udtjjXNmbw0RNbLFa4BJ2WKtemeA5UmRWf0dOkjOewzzRwXENDkWhu5lHp0sT+qOOCzhlAvvtTBfqgP8/bIYPq/aHU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5006.namprd04.prod.outlook.com
 (2603:10b6:805:91::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 15:00:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 15:00:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] zonefs: use zone-append for AIO as well
Thread-Topic: [PATCH 2/2] zonefs: use zone-append for AIO as well
Thread-Index: AQHWXpitifll0c+NqUqXemZ9Ae0oAA==
Date:   Wed, 22 Jul 2020 15:00:49 +0000
Message-ID: <SN4PR0401MB35989A410533DAF58739D53B9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
 <20200720132118.10934-3-johannes.thumshirn@wdc.com>
 <20200720134549.GB3342@lst.de>
 <SN4PR0401MB3598A542AA5BC8218C2A78D19B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200721055410.GA18032@infradead.org>
 <SN4PR0401MB3598536959BFAE08AA8DA8AD9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200722145156.GA20266@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd9f55ab-028a-4749-fb43-08d82e500554
x-ms-traffictypediagnostic: SN6PR04MB5006:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5006C177A9A3BD6061F3F9AF9B790@SN6PR04MB5006.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ua5dSrDo2A0ApzvE8faAud2r2lI6NzWhgnF5RFv+F9+jH5uQqLoQ+c5voqLUmtMIolEULfuGrdYiBzWYxiBa4AioJaRjTF+pooAQ/575/p6eaePi+JClOq3vmbVBUlvaYS3nHCe1SN9y84TKKNLJ0rQuM6cNHvMz+I3vNQm400TmiJ3K9Va8Bh7mHLfnDfJ4d8eNIsZ2PNit9zDO/gF4T85tg8sIAaqOvqf3XlBdymzdzWR4WC9uUznR7EwL6kXLjmdnbYOOAftv3yyW1vW57xmUNZXZb5g1kgnDRFHxzDE16YXu6TRet7MycPYXfsGDeL3D7QqtOhFqmY4XbUA6rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(71200400001)(6916009)(9686003)(33656002)(83380400001)(5660300002)(8936002)(2906002)(7696005)(86362001)(8676002)(53546011)(6506007)(91956017)(4326008)(66946007)(52536014)(76116006)(66476007)(66556008)(64756008)(66446008)(478600001)(54906003)(26005)(316002)(186003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ePiPOi48x30ujrwkTlam17rRz4hCTBFtmbvRD8inhmZK98oFWHG8uPjWUrBJjvyPiy5QIrx4JHf6cDxKPSS7SkvFCt+d3Mp9M7zCFo8KOZY1PmLcfVhCc/U8kZe8B+2FFJQ9U+ONqRUxOIMuHOw6avpMbGfpmFHMQioGeSsu5MQDsLQCG+ZID6Ax3CwHz4cFC8LlV0zL/ckkx66+koWVeKI8Pb79ZANrSBj31hGCAVBScYAzAzCw72aotuPACMIkVbl4Hcuddo/+5x7BMn5nVrxoKhHKWTyFRuzWzw22bQ5qTgJwnquvr/vvLfzCvjGCyKSK5NPGMS1tLbbZXvOX9aiibzNIxTGTh/QbvL01WEPsROwW8CGJpiM0xFLgeSFNWp5Av+PcRbYQKkptZmr17+Ia99044S7fDsH37cSsT1nDpPqwN2p34qO14Tb4Uq7mEjw/1PdUA4NKP8BCw7v/o1wTCJ32rhTZ4Rx53ADqJK+4tUjc5iz9Agc7yZWJc29a
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9f55ab-028a-4749-fb43-08d82e500554
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 15:00:49.2743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGVRUFwRtH6pNfHslXtm+uja5hJNmbpd+eo5DgUxCuVp+V1Mje1MFVdmxSUtJb/KYnQ9+C91vppgDfEtOy1gESrZ8PmQM+km9vvBGBooaEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5006
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/07/2020 16:52, Christoph Hellwig wrote:=0A=
> On Wed, Jul 22, 2020 at 12:43:21PM +0000, Johannes Thumshirn wrote:=0A=
>> On 21/07/2020 07:54, Christoph Hellwig wrote:=0A=
>>> On Mon, Jul 20, 2020 at 04:48:50PM +0000, Johannes Thumshirn wrote:=0A=
>>>> On 20/07/2020 15:45, Christoph Hellwig wrote:=0A=
>>>>> On Mon, Jul 20, 2020 at 10:21:18PM +0900, Johannes Thumshirn wrote:=
=0A=
>>>>>> On a successful completion, the position the data is written to is=
=0A=
>>>>>> returned via AIO's res2 field to the calling application.=0A=
>>>>>=0A=
>>>>> That is a major, and except for this changelog, undocumented ABI=0A=
>>>>> change.  We had the whole discussion about reporting append results=
=0A=
>>>>> in a few threads and the issues with that in io_uring.  So let's=0A=
>>>>> have that discussion there and don't mix it up with how zonefs=0A=
>>>>> writes data.  Without that a lot of the boilerplate code should=0A=
>>>>> also go away.=0A=
>>>>>=0A=
>>>>=0A=
>>>> OK maybe I didn't remember correctly, but wasn't this all around =0A=
>>>> io_uring and how we'd report the location back for raw block device=0A=
>>>> access?=0A=
>>>=0A=
>>> Report the write offset.  The author seems to be hell bent on making=0A=
>>> it block device specific, but that is a horrible idea as it is just=0A=
>>> as useful for normal file systems (or zonefs).=0A=
>>=0A=
>> After having looked into io_uring I don't this there is anything that=0A=
>> prevents io_uring from picking up the write offset from ki_complete's=0A=
>> res2 argument. As of now io_uring ignores the filed but that can be =0A=
>> changed.=0A=
> =0A=
> Sure.  Except for the fact that the io_uring CQE doesn't have space=0A=
> for it.  See the currently ongoing discussion on that..=0A=
=0A=
That one I was aware of, but I thought once that discussion has settled=0A=
the write offset can be copied from res2 into what ever people have agreed=
=0A=
on by then.=0A=
=0A=
> =0A=
>> So the only thing that needs to be done from a zonefs perspective is =0A=
>> documenting the use of res2 and CC linux-aio and linux-abi (including=0A=
>> an update of the io_getevents man page).=0A=
>>=0A=
>> Or am I completely off track now?=0A=
> =0A=
> Yes.  We should not have a different ABI just for zonefs.  We need to=0A=
> support this feature in a generic way and not as a weird one off for=0A=
> one filesystem and only with the legacy AIO interface.=0A=
=0A=
OK, will have a look.=0A=
=0A=
> Either way please make sure you properly separate the interface (=0A=
> using Write vs Zone Append in zonefs) from the interface (returning=0A=
> the actually written offset from appending writes), as they are quite=0A=
> separate issues.=0A=
=0A=
So doing async RWF_APPEND writes using Zone Append isn't the problem here,=
=0A=
it's "only" the reporting of the write offset back to user-space? So once=
=0A=
we have sorted this out we can start issuing zone appends for zonefs async=
=0A=
writes?=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
=0A=
