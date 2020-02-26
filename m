Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 416C316F589
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 03:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgBZCMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 21:12:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7746 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgBZCMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582683163; x=1614219163;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EsAM0713LoEqlxQJhFrrIzca3hpAsfAWsK/oPa12ysQ=;
  b=ZMpyAEI0DKXeGc7+lhszDh8IkJUnD1EZeUWtAPKsmgqGrsG5u/m9L2/r
   OcPHPtBVJC7nRF1wqvXFIgMqs0nAloMaHH6u0jDeeN78eYSJ6XEPsE/wF
   u4Z4dmWNAbD3CTLV0SrOaCMevG9OBnFx6Bjz85TK9+4ataWhHzvnV/nni
   1VLjcJXoC1H+901sk4CNPyOwP9L2rGgJscyBNbiMItKJakKep322T+Yi6
   mYkShzB3dfE3GcodSrFXBWOrndPz7iV2nqsprqdiG8QDSorpeP6THaKC9
   5kRqtXKqOW5o3GPDJ9kIUpjPGa/3p+QvpJYE3tRjY9Ie3H5vhtobBIeQW
   w==;
IronPort-SDR: uYx+vmlrfdHPtwJzHva0Uq64xOCU0KgUMb4WEDVZ3mD+r+tuxBACKvLxH65LK1br/9geoIBvOz
 tgWD/tuiEXrSD/wCeuuLX7JkbObBDt1wQNcsYmVbJcBxqd1dJHeFD/FBOt4PoswVgaAemj69M5
 jTtlKqYLMfeC7IxkIm8+JvIX93sZdyPbC4K55onveY+1hxToDIYLE1hXOJObv5/+ZJ2dEpTfGk
 U3eHjAuTO0justi0cb2Oc43xZnd/ijHXe2D9j7naGcIirB4rrfw8ENo/jpLUyVASkGQ1Nc4R0E
 9JQ=
X-IronPort-AV: E=Sophos;i="5.70,486,1574092800"; 
   d="scan'208";a="135138171"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2020 10:12:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6mqw6GZu8AAR94hddslXWpr9g4GWh41vwaBpIJ+yEpmZ6HoIN2KL+a120MRc+Mlb8/tPRajWCkwZXpCv2K3+goJejeQ+2hpCTFYIuBLLmcnsatErBBCQXpOVo8AIebieD4swzV8wuOy9MTPTytfwF+/rQpIrG++GJ3eEn4+N4oTd7b9eE6vziTloFz/5kCe0U1tkiDRTC7j78asDK27T0Y+uvOqrd/lC1mAMJrKTCUJCdau8ltd7dTef1CmzorIr1Tim6MzqmazViP/8RXjh2gI8IUBwFa26P1Cuce2AYc9YIdtqPZu7TUAruFWIWhYkSwp1yaJ0rA2eYl82dI7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmirw2AmmlKJo8iDV2YuEC/g9VS9dVu4SMng7T+RilU=;
 b=gc/0NhoAdahUYtNPFd2FBSWnBDHJGhybnRtkq7VqB3uVtWvuJRgx0rLrqBsGeoPoaRq+c4IblZepDq+a/ibiOQSwnKz8fPvPYF1piSrs5WMZyeBdWlyWIe1GaiqTnBNB2bW0pdnZGe1GQmf7w5yMnFqlPNbvBosETrgZ1cyvBE7guP7QPWtyoOcfhEfKt850JnL6aD30DEcxAZAfGw9UaVbR2xJ4iwLq6mMW9gd4JUyl9vUeJqP0S+W2dbCpRBpKQ+zqL/9uU+GJCLocNrxwssSIhn4bHoiDnTAXc12EigQPVpoRc3aPCOzxTLZG8aXw5Ei0RZ9ytB15sOR6h0Zguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmirw2AmmlKJo8iDV2YuEC/g9VS9dVu4SMng7T+RilU=;
 b=yshA2DyKA/NOs9idfqV5e5YRDXCOYRvsPYMTSM4gk4XYutoxIdVHBcOe97o8/C/BGuNP4US6O9v26o0mPX+nAkwzZaruAnZP7YoFXcBBGmM/hLv+cVQYIADILalTOheFILQNQIIEd4avNukKGx6yOu+tbZCbCaIFYSOc9F+iWcA=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (2603:10b6:a03:10e::16)
 by BYAPR04MB3830.namprd04.prod.outlook.com (2603:10b6:a02:b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 02:12:40 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2%6]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 02:12:40 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
CC:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Thread-Topic: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Thread-Index: AQHV6AHTnTB6gZBg10G6wfTtrUQyIQ==
Date:   Wed, 26 Feb 2020 02:12:40 +0000
Message-ID: <BYAPR04MB58167849C121A55413A88012E7EA0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200220152355.5ticlkptc7kwrifz@fiona>
 <20200221045110.612705204E@d06av21.portsmouth.uk.ibm.com>
 <20200225205342.GA12066@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7b5b2a2-9f8e-4bd6-eb4b-08d7ba615b69
x-ms-traffictypediagnostic: BYAPR04MB3830:
x-microsoft-antispam-prvs: <BYAPR04MB38309D9800DDCB6E01FB109FE7EA0@BYAPR04MB3830.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(199004)(189003)(71200400001)(52536014)(110136005)(8676002)(26005)(316002)(6506007)(33656002)(81156014)(478600001)(53546011)(81166006)(54906003)(2906002)(7696005)(66446008)(4326008)(66476007)(76116006)(86362001)(186003)(5660300002)(64756008)(55016002)(9686003)(66946007)(66556008)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3830;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /lntnQDM9EtNSoRZWDBg0G+d4irWnz/rigsezXPtiJZyTP44LXDb7GIHmknX3PmO1rvAtTAcbWzAtpcGPdu0b3i5ImqC3qpMwCzAxNN8jbiJcVwyUR3qTWAn7GdQBb/yWWFUrUOhoV+UdDIXnnUEM8eng/H33X7OaclzdKN+McZqExan65mcvRdpevkdr8iLd6LAhTym3CDAY6WT3c+ndZhG5SrjKQ/WttHAGa52WFz1g8qvK39meprM7X65Uou7m3mtM/P3a5uZnDJ7m3uEjxCvVxslj/gvvulpexow0T92g65stcugzIpPTRxVC1RCb+zUQfz/ZbM12uh/fqG5XmiEg6h3cbjR0cPSxZnbaYj3yCVl1XVstI7bL9Ka8z6HRMYmutLsq/CHiMsmDXJfwuwgBOPgbNyWGGM/OffIR/dhBJqG7MpUlbmjeDUzHmjB
x-ms-exchange-antispam-messagedata: JP4TK/3TKc9233hwmoKjjiXTtZtvD3Ym4NlYDgwLQFg/o5J9Hv/yGrFr2STBh562R9T46/vzbWeKEouiK68ihDg2Cg0LcGbuNJTe8cL1ZyyS/ZNBPbNHaWCWFs/nrSi3+iXvGeHFCd5EjldFx9EqEg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b5b2a2-9f8e-4bd6-eb4b-08d7ba615b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 02:12:40.2547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ii1rbDL9mUgfyibnEYYuaTSY+5926VGeiX2WpoflDGfko8gRDfNqPfOM823cFoC1eW83pR4dZUkcKlCiF2usSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3830
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/02/26 5:53, Christoph Hellwig wrote:=0A=
> On Fri, Feb 21, 2020 at 10:21:04AM +0530, Ritesh Harjani wrote:=0A=
>>>   		if (dio->error) {=0A=
>>>   			iov_iter_revert(dio->submit.iter, copied);=0A=
>>> -			copied =3D ret =3D 0;=0A=
>>> +			ret =3D 0;=0A=
>>>   			goto out;=0A=
>>>   		}=0A=
>>=0A=
>> But if I am seeing this correctly, even after there was a dio->error=0A=
>> if you return copied > 0, then the loop in iomap_dio_rw will continue=0A=
>> for next iteration as well. Until the second time it won't copy=0A=
>> anything since dio->error is set and from there I guess it may return=0A=
>> 0 which will break the loop.=0A=
> =0A=
> In addition to that copied is also iov_iter_reexpand call.  We don't=0A=
> really need the re-expand in case of errors, and in fact we also=0A=
> have the iov_iter_revert call before jumping out, so this will=0A=
> need a little bit more of an audit and properly documented in the=0A=
> commit log.=0A=
> =0A=
>>=0A=
>> Is this the correct flow? Shouldn't the while loop doing=0A=
>> iomap_apply in iomap_dio_rw should also break in case of=0A=
>> dio->error? Or did I miss anything?=0A=
> =0A=
> We'd need something there iff we care about a good number of written=0A=
> in case of the error.  Goldwyn, can you explain what you need this=0A=
> number for in btrfs?  Maybe with a pointer to the current code base?=0A=
=0A=
Not sure about btrfs, but for zonefs, getting the partial I/O count done fo=
r a=0A=
failed large dio would also be useful to avoid having to do the error recov=
ery=0A=
dance with report zones for getting the current zone write pointer.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
