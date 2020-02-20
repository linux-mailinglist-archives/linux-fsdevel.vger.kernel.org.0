Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5991653F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 02:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgBTA7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 19:59:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6386 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgBTA7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582160414; x=1613696414;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=f2gnVxd64gQ/BsSMhTe9K3+TA83VL4ssuq5bv37wt48=;
  b=DpAX+wAWNG69IZfKYU3lrnQn8eQ6nJakQ3C3j2SjL51SXjXQelu5ngRQ
   aDMGfuSu07znYA3taxbbEm8jyK3jVVtTTcpWGMR2EkQ8MFTujGYXk1WAA
   m/ElAq8lacUFeKa8o3yb3m1wmFb/PZNvXKUVUpM2tJMsT6suZSf3iAG3D
   fkPB448bc5sLOAxoNWkLGSpCMduO2dRurThoO5wiJ7umzidf4HjgB6RlW
   9PxdG5y0ldMLQ2gcqWke17uhV5btGr9QzKAPZT+uTTk2sllErwa1P7ZNN
   QVQy5X8XLVH8XYN6ICDkkxZw1G2McS1Xru4QP+zrTdetaCItyg4XK/3CP
   g==;
IronPort-SDR: 30VM32P3sxtbPe018bg5TQD0prcJmiczfvKN+4/UsjPbQeCa6gSmN/78ZGnhPJUr6tzmGg4BWL
 l7dHceGOxYInlAap5V5eIf/iNtKExeibJ66ucBAlKO3cDjP2en56kYQXZGX/wHsApk65OGKO+R
 dKlmPMqrGtPG2WkCffE7bj9gPjZz+YwWsxRRmGfH8kSs+Vvo6Euwk/LoSPdYocwUtZmXlrXc5u
 xzV9MS36tZCagy3Ns0n8+BwesR2UlU4IM0vxjNz8XvnuX6zX+jYm020F0cub3wWwD//zjIbMEy
 jSA=
X-IronPort-AV: E=Sophos;i="5.70,462,1574092800"; 
   d="scan'208";a="232104381"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2020 09:00:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ts5q1uCpQS8pyB0HZOMVJ+yJ0ebHt9YTdIJLvwBi1xfr3WPUKGaDxAY2+cCuWXVlxQO7S3RWZTAO81MITYRX0Fl+/kQ1r+PEF/3nEMYTraAA4YLKW5mtSiKLOYauQQ3qAElpD2WhfoALkWv+SsroS5cM+IAaUWnJw+nWMATlKVT0zPhm61AEBPdlwKwK2zRONlgCmYsWauly12CMfX/FbTPmM2a9RWDVOKacjHqFrymJAeemReE8jQnzoxSb6kJsdHe2k4YKDSeco2cdw5WLdPnfD651cm15Tu26vSoAogWIj17FB54MCrXnvWy62CwnMz9vLdteVX1tDXkFYNgtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6bF4PhPotIufF7v8dDukqLaRUbIiVYinGIXlv1NmhE=;
 b=BIX7aP35TqaskZOH9Edk9M3I4V8pF4NYrJgir1Ecoj2m3SrrPQ7O7dORhl6kbwVJ+46Q0miitlKvZh4cd3NBseGi42D8h19OXWjXTcrbsMT0RiUBLZaJW0/aaatwIFVF9F5h7jI2ZMvEbQI6HzWFZnLr6ET6VaokfI4Vxap7tLL6syDJaJNx7s+34Dq/qxnLoLQgZzSrjpyVlj/tSbrL2/j0fSXy52aYimMOv1s9teIRVYyktM2Zx+1g5/OQmGZHjinRy/G6JUG9vTAzuQZoxjTI7kyf8upbJmpgbKbwTfaY7zFkYSSKimlK6JBNLe8KOASX0VK4URvB5cBkBGD2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6bF4PhPotIufF7v8dDukqLaRUbIiVYinGIXlv1NmhE=;
 b=uTiM+i0OFG4XIikHnexYlBs+9MYyKbhAUEVz9GNaR8XXyddz7XG66RJg7fLosByamImwDQr17ATJxR9dirTp/gy3dW+g0+TDQwyQ90dDiUpY0J0R2SieBp31XTw6pInu+MsD7EdpBahPeqJl5UqzkpwRIabOrZ4rzyCEQ4LERcc=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4471.namprd04.prod.outlook.com (52.135.240.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 20 Feb 2020 00:59:30 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2%6]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 00:59:30 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v13 2/2] zonefs: Add documentation
Thread-Topic: [PATCH v13 2/2] zonefs: Add documentation
Thread-Index: AQHV3WUG8VHDXlviiEuGzaH6PP2QeQ==
Date:   Thu, 20 Feb 2020 00:59:29 +0000
Message-ID: <BYAPR04MB58167DDA2AE7B1BC1500D9C4E7130@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200207031606.641231-1-damien.lemoal@wdc.com>
 <20200207031606.641231-3-damien.lemoal@wdc.com>
 <a6f0eaf4-933f-8c15-6f0c-18400204791f@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c034bda3-cfd7-4b4b-c46e-08d7b5a02414
x-ms-traffictypediagnostic: BYAPR04MB4471:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB447123706F7EF9A749224110E7130@BYAPR04MB4471.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(53546011)(26005)(8676002)(5660300002)(2906002)(81166006)(186003)(81156014)(33656002)(86362001)(7696005)(110136005)(54906003)(8936002)(9686003)(55016002)(4326008)(6506007)(316002)(66446008)(52536014)(64756008)(71200400001)(66946007)(66556008)(478600001)(66476007)(91956017)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4471;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zjD1iQXsS0MjeijwDw0sXbvYbWNs5aDq7wpR/3a1vfzx5PX+gnZ6ZQO/p8sjAS0Uigoe3dgfAwHRJGXu2JkhsjOmbALdw+dOPJW5aldkbYxZx1oQjmabfHVailzANI/Z6SQH7BXzibMqQvMj5xeFPoVUaQ71AKwCefYqEXF+YoVc3yB33JFzMEONewMPT9l+zsBmerYDWyQKFzes0RwteQSFMlVHKQg60iSSNNmOR/Q0qkczUKYEwz9rspoyflYOL2hRZ/XQtEve2fDanvCDc/9zwzepaIYOEjJ6jzcqvrDcCaV+Szl/WQosp1db84K3Yj6gw4Jssrxxev8iLe8yxsLRmdITMygSTEv/y6ZZBKy45hLblK7Y+pHqBFCdNDLaS8Su1R322uozcZuTv5Uh9ZZjKjK8PconEuIsb4iyYWg0KkFpifCM2tQDXUE8RB3k
x-ms-exchange-antispam-messagedata: nVe6pgu+BMZZFOOcj848PPhT/xArv3udR8SVQlC5ELFTpaqYfbVP/s498jijEF9C0FCnQIO3yOA7F0fMr8GaNZQUifluPvfrnQSn9Nits+uus7u9PyM8TbKZ1tPtD4eFMJBcR29RIi1VQHMG7SkRtw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c034bda3-cfd7-4b4b-c46e-08d7b5a02414
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 00:59:29.9081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qsJtc/rf8KBsHmBC0pi0zQ54mDffrc9yK8rTljodMVhARWSppKJcKLbEW2n5PrNdoTsj8WFjYxFX0TwG51HZdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4471
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/02/20 9:55, Randy Dunlap wrote:=0A=
> Hi Damien,=0A=
> =0A=
> Typo etc. corrections below:=0A=
=0A=
Thanks. Will correct these. Since this is now in the kernel, you can send a=
=0A=
patch too :)=0A=
=0A=
> =0A=
> On 2/6/20 7:16 PM, Damien Le Moal wrote:=0A=
>> Add the new file Documentation/filesystems/zonefs.txt to document=0A=
>> zonefs principles and user-space tool usage.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Reviewed-by: Dave Chinner <dchinner@redhat.com>=0A=
>> ---=0A=
>>  Documentation/filesystems/zonefs.txt | 404 +++++++++++++++++++++++++++=
=0A=
>>  MAINTAINERS                          |   1 +=0A=
>>  2 files changed, 405 insertions(+)=0A=
>>  create mode 100644 Documentation/filesystems/zonefs.txt=0A=
>>=0A=
>> diff --git a/Documentation/filesystems/zonefs.txt b/Documentation/filesy=
stems/zonefs.txt=0A=
>> new file mode 100644=0A=
>> index 000000000000..935bf22031ca=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/filesystems/zonefs.txt=0A=
>> @@ -0,0 +1,404 @@=0A=
>> +ZoneFS - Zone filesystem for Zoned block devices=0A=
>> +=0A=
>> +Introduction=0A=
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>> +=0A=
> ...=0A=
>> +=0A=
>> +Zoned block devices=0A=
>> +-------------------=0A=
>> +=0A=
> ...=0A=
>> +=0A=
>> +Zonefs Overview=0A=
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>> +=0A=
> ...=0A=
> =0A=
>> +=0A=
>> +On-disk metadata=0A=
>> +----------------=0A=
>> +=0A=
> ...=0A=
> =0A=
>> +=0A=
>> +Zone type sub-directories=0A=
>> +-------------------------=0A=
>> +=0A=
> ...=0A=
> =0A=
>> +=0A=
>> +Zone files=0A=
>> +----------=0A=
>> +=0A=
> ...=0A=
> =0A=
>> +=0A=
>> +Conventional zone files=0A=
>> +-----------------------=0A=
>> +=0A=
> ...=0A=
> =0A=
>> +=0A=
>> +Sequential zone files=0A=
>> +---------------------=0A=
>> +=0A=
>> +The size of sequential zone files grouped in the "seq" sub-directory re=
presents=0A=
>> +the file's zone write pointer position relative to the zone start secto=
r.=0A=
>> +=0A=
>> +Sequential zone files can only be written sequentially, starting from t=
he file=0A=
>> +end, that is, write operations can only be append writes. Zonefs makes =
no=0A=
>> +attempt at accepting random writes and will fail any write request that=
 has a=0A=
>> +start offset not corresponding to the end of the file, or to the end of=
 the last=0A=
>> +write issued and still in-flight (for asynchrnous I/O operations).=0A=
>                                          asynchronous=0A=
> =0A=
>> +=0A=
>> +Since dirty page writeback by the page cache does not guarantee a seque=
ntial=0A=
>> +write pattern, zonefs prevents buffered writes and writeable shared map=
pings=0A=
>> +on sequential files. Only direct I/O writes are accepted for these file=
s.=0A=
>> +zonefs relies on the sequential delivery of write I/O requests to the d=
evice=0A=
>> +implemented by the block layer elevator. An elevator implementing the s=
equential=0A=
>> +write feature for zoned block device (ELEVATOR_F_ZBD_SEQ_WRITE elevator=
 feature)=0A=
>> +must be used. This type of elevator (e.g. mq-deadline) is the set by de=
fault=0A=
> =0A=
>                                                           is set by defau=
lt=0A=
> =0A=
>> +for zoned block devices on device initialization.=0A=
>> +=0A=
> ...=0A=
> =0A=
>> +=0A=
>> +Format options=0A=
>> +--------------=0A=
>> +=0A=
> ...=0A=
> =0A=
>> +=0A=
>> +IO error handling=0A=
>> +-----------------=0A=
>> +=0A=
> ...=0A=
> =0A=
>> +=0A=
>> +=0A=
>> +* Unaligned write errors: These errors result from the host issuing wri=
te=0A=
>> +  requests with a start sector that does not correspond to a zone write=
 pointer=0A=
>> +  position when the write request is executed by the device. Even thoug=
h zonefs=0A=
>> +  enforces sequential file write for sequential zones, unaligned write =
errors=0A=
>> +  may still happen in the case of a partial failure of a very large dir=
ect I/O=0A=
>> +  operation split into multiple BIOs/requests or asynchronous I/O opera=
tions.=0A=
>> +  If one of the write request within the set of sequential write reques=
ts=0A=
>> +  issued to the device fails, all write requests after queued after it =
will=0A=
> =0A=
>                                            requests queued after it=0A=
> =0A=
>> +  become unaligned and fail.=0A=
>> +=0A=
> ...=0A=
> =0A=
>> +=0A=
>> +All I/O errors detected by zonefs are notified to the user with an erro=
r code=0A=
>> +return for the system call that trigered or detected the error. The rec=
overy=0A=
> =0A=
>                                    triggered=0A=
> =0A=
>> +actions taken by zonefs in response to I/O errors depend on the I/O typ=
e (read=0A=
>> +vs write) and on the reason for the error (bad sector, unaligned writes=
 or zone=0A=
>> +condition change).=0A=
>> +=0A=
> ...=0A=
> =0A=
>> +=0A=
>> +Zonefs minimal I/O error recovery may change a file size and a file acc=
ess=0A=
> =0A=
>                                                             and file acce=
ss=0A=
> =0A=
>> +permissions.=0A=
>> +=0A=
>> +* File size changes:=0A=
>> +  Immediate or delayed write errors in a sequential zone file may cause=
 the file=0A=
>> +  inode size to be inconsistent with the amount of data successfully wr=
itten in=0A=
>> +  the file zone. For instance, the partial failure of a multi-BIO large=
 write=0A=
>> +  operation will cause the zone write pointer to advance partially, eve=
n though=0A=
>> +  the entire write operation will be reported as failed to the user. In=
 such=0A=
>> +  case, the file inode size must be advanced to reflect the zone write =
pointer=0A=
>> +  change and eventually allow the user to restart writing at the end of=
 the=0A=
>> +  file.=0A=
>> +  A file size may also be reduced to reflect a delayed write error dete=
cted on=0A=
>> +  fsync(): in this case, the amount of data effectively written in the =
zone may=0A=
>> +  be less than originally indicated by the file inode size. After such =
I/O=0A=
>> +  error, zonefs always fixes a file inode size to reflect the amount of=
 data=0A=
> =0A=
>                           fixes the file inode size=0A=
> =0A=
>> +  persistently stored in the file zone.=0A=
>> +=0A=
>> +* Access permission changes:=0A=
> ...=0A=
> =0A=
>> +=0A=
>> +Further notes:=0A=
>> +* The "errors=3Dremount-ro" mount option is the default behavior of zon=
efs I/O=0A=
>> +  error processing if no errors mount option is specified.=0A=
>> +* With the "errors=3Dremount-ro" mount option, the change of the file a=
ccess=0A=
>> +  permissions to read-only applies to all files. The file system is rem=
ounted=0A=
>> +  read-only.=0A=
>> +* Access permission and file size changes due to the device transitioni=
ng zones=0A=
>> +  to the offline condition are permanent. Remounting or reformating the=
 device=0A=
> =0A=
>                                              usually:      reformatting=
=0A=
> =0A=
>> +  with mkfs.zonefs (mkzonefs) will not change back offline zone files t=
o a good=0A=
>> +  state.=0A=
>> +* File access permission changes to read-only due to the device transit=
ioning=0A=
>> +  zones to the read-only condition are permanent. Remounting or reforma=
ting=0A=
> =0A=
>                                                                    reform=
atting=0A=
> =0A=
>> +  the device will not re-enable file write access.=0A=
>> +* File access permission changes implied by the remount-ro, zone-ro and=
=0A=
>> +  zone-offline mount options are temporary for zones in a good conditio=
n.=0A=
>> +  Unmounting and remounting the file system will restore the previous d=
efault=0A=
>> +  (format time values) access rights to the files affected.=0A=
>> +* The repair mount option triggers only the minimal set of I/O error re=
covery=0A=
>> +  actions, that is, file size fixes for zones in a good condition. Zone=
s=0A=
>> +  indicated as being read-only or offline by the device still imply cha=
nges to=0A=
>> +  the zone file access permissions as noted in the table above.=0A=
>> +=0A=
>> +Mount options=0A=
>> +-------------=0A=
>> +=0A=
>> +zonefs define the "errors=3D<behavior>" mount option to allow the user =
to specify=0A=
>> +zonefs behavior in response to I/O errors, inode size inconsistencies o=
r zone=0A=
>> +condition chages. The defined behaviors are as follow:=0A=
> =0A=
>              changes.=0A=
> =0A=
>> +* remount-ro (default)=0A=
>> +* zone-ro=0A=
>> +* zone-offline=0A=
>> +* repair=0A=
>> +=0A=
>> +The I/O error actions defined for each behavior is detailed in the prev=
ious=0A=
> =0A=
>                                                    are=0A=
> =0A=
>> +section.=0A=
>> +=0A=
>> +Zonefs User Space Tools=0A=
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0A=
>> +=0A=
> ...=0A=
>> +=0A=
>> +Examples=0A=
>> +--------=0A=
>> +=0A=
> ...=0A=
> =0A=
> =0A=
> HTH.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
