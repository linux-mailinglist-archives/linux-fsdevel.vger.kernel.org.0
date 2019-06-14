Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20383451C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 04:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFNCHT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 22:07:19 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:16028 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfFNCHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560478055; x=1592014055;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RVyrK1Nd0SKOMaBbmkdjUKhIVOY//5PpjjyPE/NIkNk=;
  b=RgTkRdwsniJfcyxFBMnHRoyiiidqh846DSFQK2BN3SRvC9LknpDKg5Zu
   QmBNE/TJIxWKFKeoh8WEEkFl4pOjaAZ0KW4YxlxZB5+Re4qX3iKirGZk4
   itEeH4iyGKThuivMEvkML5jRfBY8Wpe/D0v747MMnXxorm+byujbbmFTn
   LNRdxC4kH/01H71xMCTLGlRMt1Pp3pdEsKr825Mn2ZfMYgJh+uGhUy/NR
   f/azcJSRQkdP5UiuC0HfneqiGF3v9tfiBGtjVYXN7kjzrPHpohYs1PUtR
   3+jmMayaNbJNTV+cwQkuEn4nbRSCCLF02CME9g8MYrg/xr/lo14lygg12
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,371,1557158400"; 
   d="scan'208";a="210237802"
Received: from mail-by2nam03lp2055.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.55])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2019 10:07:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVyrK1Nd0SKOMaBbmkdjUKhIVOY//5PpjjyPE/NIkNk=;
 b=wAZBxDO12kL9VjI0aCocPBpyHRw1CeaXExSV9iuyOO0e+iVYpew1vFKc6emqcE0GxRGBOuJ9tmvLbSCQWiUnmqOIUwV3rkAoVgI32m2aNsRmJ6Jt46JQjwKOfim3u3Le0Qae4OH9VjF61Uww21CVV8hobD57hRSZzESu1cBmaHE=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB5263.namprd04.prod.outlook.com (20.178.7.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Fri, 14 Jun 2019 02:07:15 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 02:07:15 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 00/19] btrfs zoned block device support
Thread-Topic: [PATCH v2 00/19] btrfs zoned block device support
Thread-Index: AQHVHTKAMt+QxADp/024sRBo1BQ8yw==
Date:   Fri, 14 Jun 2019 02:07:15 +0000
Message-ID: <SN6PR04MB5231FF124F9BF2FCB3EDB8F58CEE0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190612175138.GT3563@twin.jikos.cz>
 <SN6PR04MB5231E2F482B8D794950058FF8CEF0@SN6PR04MB5231.namprd04.prod.outlook.com>
 <20190613134612.GU3563@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae409566-791f-4d7d-59aa-08d6f06d05d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5263;
x-ms-traffictypediagnostic: SN6PR04MB5263:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB5263936E145926A2BC4415148CEE0@SN6PR04MB5263.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(53376002)(99286004)(316002)(6436002)(54906003)(966005)(6116002)(7736002)(9686003)(33656002)(6246003)(6506007)(3846002)(76176011)(305945005)(68736007)(66556008)(8936002)(25786009)(72206003)(26005)(256004)(53936002)(55016002)(2906002)(52536014)(5640700003)(86362001)(6306002)(229853002)(478600001)(14454004)(74316002)(66066001)(53546011)(102836004)(73956011)(1730700003)(5660300002)(7696005)(2501003)(476003)(71200400001)(186003)(66946007)(66476007)(6916009)(76116006)(8676002)(81156014)(71190400001)(2351001)(486006)(91956017)(66446008)(81166006)(7416002)(446003)(4326008)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5263;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TcHYyk3xajPxPn0Z0pZ0bvZWaK1Ch5k1vNPbG96quv5ApKGsz9pykcm/BTFoQOm4zXoDYXAIPVshpCvJvXCDsA9hN1b9MXoQ254NZVA08xARGQWYZF7FjlWpL89P7z74O1pyTvAK94pM3COWZq0UkeslcmY71TtzVo9vNULMp3oPXvIPpH5OZXbOopikUQD6bwAozX3tc99fbIRzQlnW/yV4DuPvigsWFQMmtpTabHYfCUCbzLLZYT5eULuF65JFLoJHFPZqUplLhRvEz7fqwjROkwLRe6y/SZqJyOTiiRERvbz1duCWSqBq+Aa3Ec/TlPdXj12Xmv+GarMJOx9Z8r/9+GjYCf/IgJZEyRuqIti1BLTE2G2FzY+fB6/7au0BqgpalHM1zDTIxijkFHAVLX3k5RMBWka0HIKoeKT7AdU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae409566-791f-4d7d-59aa-08d6f06d05d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 02:07:15.8550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5263
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/13 22:45, David Sterba wrote:> On Thu, Jun 13, 2019 at 04:59:23A=
M +0000, Naohiro Aota wrote:=0A=
>> On 2019/06/13 2:50, David Sterba wrote:=0A=
>>> On Fri, Jun 07, 2019 at 10:10:06PM +0900, Naohiro Aota wrote:=0A=
>>> How can I test the zoned devices backed by files (or regular disks)? I=
=0A=
>>> searched for some concrete example eg. for qemu or dm-zoned, but closes=
t=0A=
>>> match was a text description in libzbc README that it's possible to=0A=
>>> implement. All other howtos expect a real zoned device.=0A=
>>=0A=
>> You can use tcmu-runer [1] to create an emulated zoned device backed by=
=0A=
>> a regular file. Here is a setup how-to:=0A=
>> http://zonedstorage.io/projects/tcmu-runner/#compilation-and-installatio=
n>> That looks great, thanks. I wonder why there's no way to find that, all=
=0A=
> I got were dead links to linux-iscsi.org or tutorials of targetcli that=
=0A=
> were years old and not working.=0A=
=0A=
Actually, this is quite new site. ;-)=0A=
=0A=
> Feeding the textual commands to targetcli is not exactly what I'd=0A=
> expect for scripting, but at least it seems to work.=0A=
=0A=
You can use "targetcli <directory> <command> [<args> ...]" format, so=0A=
you can call e.g.=0A=
=0A=
targetcli /backstores/user:zbc create name=3Dfoo size=3D10G cfgstring=3Dmod=
el-HM/zsize-256/conv-1@/mnt/nvme/disk0.raw=0A=
=0A=
> I tried to pass an emulated ZBC device on host to KVM guest (as a scsi=0A=
> device) but lsscsi does not recognize that it as a zonde device (just a=
=0A=
> QEMU harddisk). So this seems the emulation must be done inside the VM.=
=0A=
=0A=
Oops, QEMU hide the detail.=0A=
=0A=
In this case, you can try exposing the ZBC device via iSCSI.=0A=
=0A=
On the host:=0A=
(after creating the ZBC backstores)=0A=
# sudo targetcli /iscsi create=0A=
Created target iqn.2003-01.org.linux-iscsi.naota-devel.x8664:sn.f4f308e4892=
c.=0A=
Created TPG 1.=0A=
Global pref auto_add_default_portal=3Dtrue=0A=
Created default portal listening on all IPs (0.0.0.0), port 3260.=0A=
# TARGET=3D"iqn.2003-01.org.linux-iscsi.naota-devel.x8664:sn.f4f308e4892c"=
=0A=
=0A=
(WARN: Allow any node to connect without any auth)=0A=
# targetcli /iscsi/${TARGET}/tpg1 set attribute generate_node_acls=3D1=0A=
Parameter generate_node_acls is now '1'.=0A=
( or you can explicitly allow an initiator)=0A=
# TCMU_INITIATOR=3Diqn.2018-07....=0A=
# targecli /iscsi/${TARGET}/tpg1/acls create ${TCMU_INITIATOR}=0A=
=0A=
(for each backend)=0A=
# targetcli /iscsi/${TARGET}/tpg1/luns create /backstores/user:zbc/foo=0A=
Created LUN 0.=0A=
=0A=
Then, you can login to the iSCSI on the KVM guest like:=0A=
=0A=
# iscsiadm -m discovery -t st -p $HOST_IP=0A=
127.0.0.1:3260,1 iqn.2003-01.org.linux-iscsi.naota-devel.x8664:sn.f4f308e48=
92c=0A=
# iscsiadm -m node -l -T ${TARGET}=0A=
Logging in to [iface: default, target: iqn.2003-01.org.linux-iscsi.naota-de=
vel.x8664:sn.f4f308e4892c, portal: 127.0.0.1,3260]=0A=
Login to [iface: default, target: iqn.2003-01.org.linux-iscsi.naota-devel.x=
8664:sn.f4f308e4892c, portal: 127.0.0.1,3260] successful.=0A=
