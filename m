Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 343F14783C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 04:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfFQCoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jun 2019 22:44:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:9663 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfFQCoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jun 2019 22:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560739445; x=1592275445;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZDR5R/CXP3LpMv/Ax+MOPt+KGN6XD3YAOJrepCUmOFo=;
  b=XpAChl4MAsDOcAu8Tqop81zPZn5+kQBdud3CUNUKW8w3uDF59gO9Wwo9
   VZ+f3dlxbrSmDF0cbRkwXq7Nb3fxG6PXJBpOmDUUBmoyOnGK6/joM2XOG
   kbUH6FWgIiaCtFp3gT/2qxo0bC+HLK/KGD6CGkzUr+3+Z2O9xx5ZIu0Pn
   vA3LhBY6nTd4a9SCKn3NxnKUcDFQKTyD7CAmewtHGEXcbc4jpS69cq3g9
   asDpZN/j+mWFpESTdwsfAZDvN3yG5xGRBsw8iTZNRzSdX6DrgbmHdJ9p3
   g5bumVAkLo6faL6pQCrJcAsVp4sFAbytWMZKKn/VuuHeWOWGT5BCaPP+t
   w==;
X-IronPort-AV: E=Sophos;i="5.63,383,1557158400"; 
   d="scan'208";a="115631615"
Received: from mail-by2nam05lp2050.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.50])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2019 10:44:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDR5R/CXP3LpMv/Ax+MOPt+KGN6XD3YAOJrepCUmOFo=;
 b=fNvZUmFvxjDs4h6t7z8KOZq7S8ABrg0we/hqKFzeAmB7y0PrpWoAq2gVx9tyxQF056U3c5SKMn4Kq7sQN88CGkT+3QuaSHJ41jq8pXUw5fB39n+mDvQe3c3n/ykYWUgvcZVDkX9Lqg6436GZXkUrbokBvGmfxYbcgeCpGhGu3ME=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5542.namprd04.prod.outlook.com (20.178.232.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Mon, 17 Jun 2019 02:44:03 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::d090:297a:d6ae:e757]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::d090:297a:d6ae:e757%4]) with mapi id 15.20.1965.018; Mon, 17 Jun 2019
 02:44:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 00/19] btrfs zoned block device support
Thread-Topic: [PATCH v2 00/19] btrfs zoned block device support
Thread-Index: AQHVHTKAJDlGAC+HkUGU89kQ+2+L3A==
Date:   Mon, 17 Jun 2019 02:44:03 +0000
Message-ID: <BYAPR04MB5816E0A249D4225633AB5EABE7EB0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190612175138.GT3563@twin.jikos.cz>
 <SN6PR04MB5231E2F482B8D794950058FF8CEF0@SN6PR04MB5231.namprd04.prod.outlook.com>
 <20190613134612.GU3563@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32671e44-a72b-4f73-4d55-08d6f2cda8e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5542;
x-ms-traffictypediagnostic: BYAPR04MB5542:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB554290947779FEAE3EC12DBFE7EB0@BYAPR04MB5542.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(199004)(189003)(486006)(66556008)(53936002)(81166006)(7416002)(33656002)(316002)(26005)(2501003)(478600001)(110136005)(7696005)(54906003)(72206003)(966005)(14454004)(66066001)(71200400001)(71190400001)(305945005)(74316002)(186003)(256004)(229853002)(52536014)(55016002)(6246003)(68736007)(4326008)(25786009)(3846002)(66946007)(53376002)(5660300002)(102836004)(76116006)(7736002)(6436002)(6116002)(9686003)(66446008)(53546011)(81156014)(99286004)(6506007)(8676002)(73956011)(86362001)(6306002)(6636002)(446003)(64756008)(2906002)(66476007)(76176011)(8936002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5542;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tJN5Z0e4U+Iuel5BclRaj8xBtWz+72OuCZEjrmFC7ZH1NtCD4Aq49wzGy4onArgees+LSe11GZV5R3qpZrzd5/2JGdqBU74BaB57YLMTib1yJ+E0CE71Tnaaynli84XJGh+NiAJTbS0FN3NVhdI2hItX3JkMc7cnN+5MYcu1KIwr3NugnihjPLczqxvdzLVG5wTz4468se6N7eqwCZerBnd9BzHqZ+Ca5FBvBo6syEuq2yH+Cb3nPCgvsXJ6IFk9WsroepeNB1BHoIaNPzetKnyZ3nlo4i77VjDOUAmVX8ivgg6qAx3VygjY2ed2zEVFWs7TJnZq1pGtAsfbqFCiSB3XxkGZ6iijFHKGNJ3fYgGCQk/zGhEWu4I8uY/PoGZy+WDrqyyTPEru++ii41JVA0/yQWLBDxq39GIp1MxVjDQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32671e44-a72b-4f73-4d55-08d6f2cda8e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 02:44:03.3221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5542
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David,=0A=
=0A=
On 2019/06/13 22:45, David Sterba wrote:=0A=
> On Thu, Jun 13, 2019 at 04:59:23AM +0000, Naohiro Aota wrote:=0A=
>> On 2019/06/13 2:50, David Sterba wrote:=0A=
>>> On Fri, Jun 07, 2019 at 10:10:06PM +0900, Naohiro Aota wrote:=0A=
>>>> btrfs zoned block device support=0A=
>>>>=0A=
>>>> This series adds zoned block device support to btrfs.=0A=
>>>=0A=
>>> The overall design sounds ok.=0A=
>>>=0A=
>>> I skimmed through the patches and the biggest task I see is how to make=
=0A=
>>> the hmzoned adjustments and branches less visible, ie. there are too=0A=
>>> many if (hmzoned) { do something } standing out. But that's merely a=0A=
>>> matter of wrappers and maybe an abstraction here and there.=0A=
>>=0A=
>> Sure. I'll add some more abstractions in the next version.=0A=
> =0A=
> Ok, I'll reply to the patches with specific things.=0A=
> =0A=
>>> How can I test the zoned devices backed by files (or regular disks)? I=
=0A=
>>> searched for some concrete example eg. for qemu or dm-zoned, but closes=
t=0A=
>>> match was a text description in libzbc README that it's possible to=0A=
>>> implement. All other howtos expect a real zoned device.=0A=
>>=0A=
>> You can use tcmu-runer [1] to create an emulated zoned device backed by =
=0A=
>> a regular file. Here is a setup how-to:=0A=
>> http://zonedstorage.io/projects/tcmu-runner/#compilation-and-installatio=
n=0A=
> =0A=
> That looks great, thanks. I wonder why there's no way to find that, all=
=0A=
> I got were dead links to linux-iscsi.org or tutorials of targetcli that=
=0A=
> were years old and not working.=0A=
=0A=
The site went online 4 days ago :) We will advertise it whenever we can. Th=
is is=0A=
intended to document all things "zoned block device" including Btrfs suppor=
t,=0A=
when we get it finished :)=0A=
=0A=
> =0A=
> Feeding the textual commands to targetcli is not exactly what I'd=0A=
> expect for scripting, but at least it seems to work.=0A=
=0A=
Yes, this is not exactly obvious, but that is how most automation with linu=
x=0A=
iscsi is done.=0A=
=0A=
> =0A=
> I tried to pass an emulated ZBC device on host to KVM guest (as a scsi=0A=
> device) but lsscsi does not recognize that it as a zonde device (just a=
=0A=
> QEMU harddisk). So this seems the emulation must be done inside the VM.=
=0A=
> =0A=
=0A=
What driver did you use for the drive ? virtio block ? I have not touch tha=
t=0A=
driver nor qemu side, so zoned block dev support is likely missing. I will =
add=0A=
it. That would be especially useful for testing with a real drive. In the c=
ase=0A=
of tcmu runner, the initiator can be started in the guest directly and the=
=0A=
target emulation done either in the guest if loopback is used, or on the ho=
st=0A=
using iscsi connection. The former is what we use all the time and so is we=
ll=0A=
tested. I have to admit that testing with iscsi is lacking... Will add that=
 to=0A=
the todo list.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
