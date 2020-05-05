Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507E21C609C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 21:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgEETBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 15:01:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:59288 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgEETBb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 15:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588705291; x=1620241291;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ktK4hNn42rkCpC+CPLBjkNHPhFeDtHRozsVgErJ4ZnU=;
  b=O/njKiTBmbvdrv25oxY/0WcP62kTXI+nEXkk6h7ADA9eH0Qufuksg8i9
   zSAclrKuwYuFghzccLqsQ9SeJhZSH9YgHEBcMoaFqOEFP/b4A+x6gAEoZ
   o6hLVFHS+/MIeUqXF2nlcNZEGVX7OL7tSasPlNvxtLOR6edscYpQ91mRn
   VuZsxuwTa9Zp+v7Dw3DCb0/7466Swx4WZy8fxnaZ+G+9aArD+VnR/CgmJ
   Vzt3C1CoVvTjURSNk9FSTVqPM9077CdRfPoS9+PVSUszt58uwHpH+96J0
   OiWtcXg8o41JSPq1Ayva0lGwGp8k8UAEanWuqnshvtHGEntuNAG9DJJcc
   w==;
IronPort-SDR: VlO7UhBTAqa1zyAc+Wxy1lXJoZOPR06MmpbhPuvWNlfR3ZjIFmqJTAbF+V53SZ1yGTcoZdd2gg
 hU6/fP8RMurS9W4EZDL1OVc43EKX5a7D1lnr1TKlF+h5ZPupuZnGgK1oZjv3P3GBQfz7ggr/ox
 MBimhBohwfVga4B7L0Jq+Dlj1xcF6PHHUtR919SK65NwyBIit0mfQiDvWd1vR7Y+kR0KqTgg2k
 yrpIvx+Uw5Z9YI6nVPgK1IgFYx0ZQenIJLKnyKgI8PX9gwgZ+b2Pz/ICVrzJMTp/IwhsPXHg0Y
 +fI=
X-IronPort-AV: E=Sophos;i="5.73,356,1583164800"; 
   d="scan'208";a="138412578"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 06 May 2020 03:01:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVeNwtiUtgnKf59OXxm+eRWhkVbkzAeLixK/3tbbtt62X4oc3tuG1/Fzk93g7ZDNOa2gJZNmAUBlrXHJ5+ZicuQPThmTx50g+iZrTTKsHWrqR1CbtqTnunYilmrkDuxEDNF8HrS1JGHGOac0ZHTRDZeYP/TrrprHBRH9uxOjkEDLb0qhWaY4foLJya/18LLSV2t1PBwzUVnGFuJBUI1NHMLLMHHVSMSa6sq6fLm3R47/gHFrRwVruQvlV9CC5dkumAOh4y2nwhWZKB8wBXeT/LOvyBoJL7jGrGO+tTS9RiPgpIZe/tq2NxleCLveZWwGWt3n+uJg5golAespLUie6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktK4hNn42rkCpC+CPLBjkNHPhFeDtHRozsVgErJ4ZnU=;
 b=hyPIXoGpJjZJMOzzhf9fcb1ZNWDkYIKkSJL8H3lEgnLSkBJpT243QAX1uRRcnkihBqkbT4SSwTgTvEJvxNk3qdr/1Z/jgu5SLt1u7HTNh6Isnmtj1UDa9LMGh1XboG32Brn2ekVa69hRSaKTxgy/2r97h9zqLNGvH8SZsYhP3CZAiBJvZDAJgKKZNz0cIGA348pF7Ywmo/7PVR5HJRwIBXaQsNT1hbxOvIDtceni9yRj4D5Uo1FBXGYVdLxJqsUUPnlcMPnAfP/tFBs1W2YJ4vg50fMOvxiIVpspCYU1YT/yzIkZegWsjB+rGKcRQeS8qYLiun/KCZEoiHXZwlmOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktK4hNn42rkCpC+CPLBjkNHPhFeDtHRozsVgErJ4ZnU=;
 b=UO9jJyK26yVkMhScYiTv9lxDyb+e9eDQTBziwJfQemNm2/xrydxhQDCAz9IUFB7eJuGBYvm936Rf0uqyu/+lMPs+yh11nymUvSEo/hOCX7FiScgDE3hsvPPXgZz3OWDGNIjZiAzXun+EAbEsXaGCmeV9jytYiMvtG7toL8f7E3I=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3694.namprd04.prod.outlook.com
 (2603:10b6:803:49::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Tue, 5 May
 2020 19:01:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.027; Tue, 5 May 2020
 19:01:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v9 00/11] Introduce Zone Append for writing to zoned block
 devices
Thread-Topic: [PATCH v9 00/11] Introduce Zone Append for writing to zoned
 block devices
Thread-Index: AQHWHUo+RfsAEdEH40mMdnfna9EXAQ==
Date:   Tue, 5 May 2020 19:01:28 +0000
Message-ID: <SN4PR0401MB359896D94D963DCFF5CC98F39BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
 <158821297686.28621.178479649242411251.b4-ty@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c49385b-2a44-4753-1bd1-08d7f126b757
x-ms-traffictypediagnostic: SN4PR0401MB3694:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3694CF15D8B4136B4FFF9BFA9BA70@SN4PR0401MB3694.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9df2iW0MC4abcaeGOEw7wlzj0PLxc1PT841DIrfppYBKKqGlcl+hMMYRABGQCLN2s9f9yNOLcIOMDOUgxPOAldm4BL4j08OF2wgTpaF6RFp1tZrjhia0siU8f+s2iR3r7dfqV+Ab3mNm8d/8hi59ajR1mgMv2sEKl+krO2U1roKQ67q8aJqCitUHkNsYf8oSS1dsGs+aK4wMPMqRLsg5z2or3vHyoMaul2OzTrEF/8u1+Ox7vaOWrLtZRFsS3DkD8EDTPxf/nt/IZtjnfibclRLpb6iF/h2FegOvnCwxDQkDIZkld28RCqIVZ2FOC56cwVI3H/TFLjnIpqhWPqMQfht5FfsNekhfO8QrjcR6E4tuD8f/NZs4Rq/XqhDVdhneO5MtMOk5A3wGOpJGEyb0l0yZfxEurx8e6ArUtpS1vTdTEJGVhHW0R4uH4ReSrsBq8xJi8E3FIEYUIPbFIemFknSgYxqTDACxz19VV3HqJxrl+Sgc4tH3mWu4YqzSIknHvzHjVAUneFGe3uZm+W093g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(396003)(136003)(366004)(376002)(346002)(33430700001)(33656002)(33440700001)(26005)(6506007)(2906002)(186003)(7696005)(53546011)(86362001)(316002)(4326008)(55016002)(5660300002)(9686003)(71200400001)(64756008)(66946007)(52536014)(54906003)(66476007)(66446008)(66556008)(4744005)(478600001)(76116006)(6916009)(8676002)(8936002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xSn6YW4SGzep1j6iRHL1SF0OGCtR0rtdVCK7v3MqR3C0/DXFU89m4bpzXS/83NXcDOuJM1e08VfT73mqPYiWXO/7G82Omot1vp9ArQ3ahr5YtKsIHZlz3v0X/sTq31mZeaZCb9MlYP/A409JYuBA+zWM7EJUOR1lfnr5gww0RINtFa9ikBqdHGCzw97wxTXgl6iRGzlkIpkhJ5YRfw585LdSOgr1Qnw09FFCD4BI5fsxqb9ltxhSZNwQGoc9wJ4M1UcKq3aBfV8f+kphUvvlF3W6toKAwGhqV0PbpoDtg5++eokgF90CiNjQld9HUmbSN9ugMMBHf9pprJoNbilHy7lewaiuYj62g9eQogyCoC3Ai5NXDbXkeA4+Q0kwWzD2yNK6MZKGWQHv6dsEdTgTvuu+RyhecW8X2Bv5aNOYyW49Izt+rYbWPwQvogCAuHae3j1pUIqookt+fBb57j51SJYGj8K18+oKtBlZ3dj3IZq+lHfMiwaVC/bV1eOtpovv1RRiXKnpo09o4f2HJrn4lNEX0elPTU3VcO1MZ0bvPR22xCR9XbROi+2tOpAYC8pjNeqIBhxwibf51bCV24vqb7EBTYuEseO0OYlqv9Okz/FJr7i3MbiiodHaI7Il3P5ujsP8n4+GKexgDjwSorGX/+vSOuvhSUm/w2DF6mMw4EtU7ApRMbTsXChVv1iJxT1pWaNE4fmUvpOjnvDNeBvu2dPstede5sPmwgNo0uzeth1tl1MsjM+ttbrAlFQId1AC3zDc7wsDVZ2takjdu7D6XXgZ38vagYshyL2LJr2ieCI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c49385b-2a44-4753-1bd1-08d7f126b757
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 19:01:28.2155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1s1ZPTXjogX3vjTLTu/YxG592hcHq0txR70T9ao8nQeaSnbH8/WfgXd1D789+gC1WoNMsgZJTLdrhK0QUnQLmccb4Y0ZzrWLBSVDiglKB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3694
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30/04/2020 04:18, Martin K. Petersen wrote:=0A=
> On Tue, 28 Apr 2020 19:45:54 +0900, Johannes Thumshirn wrote:=0A=
> =0A=
>> The upcoming NVMe ZNS Specification will define a new type of write=0A=
>> command for zoned block devices, zone append.=0A=
>>=0A=
>> When when writing to a zoned block device using zone append, the start=
=0A=
>> sector of the write is pointing at the start LBA of the zone to write to=
.=0A=
>> Upon completion the block device will respond with the position the data=
=0A=
>> has been placed in the zone. This from a high level perspective can be=
=0A=
>> seen like a file system's block allocator, where the user writes to a=0A=
>> file and the file-system takes care of the data placement on the device.=
=0A=
>>=0A=
>> [...]=0A=
> =0A=
> Applied to 5.8/scsi-queue, thanks!=0A=
=0A=
Btw any other comments on the SCSI parts of this series or the general =0A=
architecture from your side Martin?=0A=
