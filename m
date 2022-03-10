Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84934D5457
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 23:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbiCJWNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 17:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbiCJWM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:12:58 -0500
X-Greylist: delayed 1148 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 14:11:56 PST
Received: from mx0b-003b2802.pphosted.com (mx0b-003b2802.pphosted.com [205.220.180.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FD31965C4;
        Thu, 10 Mar 2022 14:11:56 -0800 (PST)
Received: from pps.filterd (m0278969.ppops.net [127.0.0.1])
        by mx0a-003b2802.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22ALhn76014008;
        Thu, 10 Mar 2022 21:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+Ps9BTRApZBruZj1LJqmbCNfNnDoQ8okH87l+r8SYYQ=;
 b=ODGcsJ0auZTR1YPjG0sUeoGQXCLFsTkzgmyG9XjbHxiODml2QvCXZWUL75KMe7n30Y9q
 h3bq+CEnuCxBssrqs+1qMTW5NZ0wptb4ka8j7Y3lHLCxL2sty2ecfsCuj9t/QQi0ka9W
 eIos4TpFXK6dsFW7BMOfHRgoKEl1qtHGsR90kDDtTejI+SYoKPMxuEvMUTa9VHe6pNbR
 49nY9lu/98xK4V1ChL45jlv3SSasxSk3wyUKbR9DJE0M/oRhzhxF0P9ozAXRC0vzU50R
 4ig7M/lScihqsvlf/34MfKv8kOGEUqIfmlcgTGSuL50gSynCu7PptwVD07Y49y0/H5BJ Ug== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0a-003b2802.pphosted.com (PPS) with ESMTPS id 3ekwtme8pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 21:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvuOq7ZO7Q4c8hM0f32rw6xSj/Cm8cUCPrKr8ezFpJG6uKckjRXgX8ZQgAjCoKuHt3NKLVSAGllSVYIuUJLKJDEe0BXiorzFRcFQhrB1k4ikRFDWtKckPMzJvFebr74R8tOKqI1fa4HZFiAWED8W8N09Dvg0kTXd9gta9P+E+bPGx+WD7CezLJQN8goCxVZxRFmNaI++9ex9SRzPqbHeZEdTU6pDl/0Q5A6BKjtouGPT4HhsP6GcxZjcA5GcJ/Gm22Lsc5NtAAqP0RoAiNyTjZXzjHr5A818cg6/G4nd0qgoyuv2ltsDwuLWT1D6gTfUOz0knFb6QKM/PuCy1JgPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ps9BTRApZBruZj1LJqmbCNfNnDoQ8okH87l+r8SYYQ=;
 b=nLGoRd85vtlFxSgqdNbbcMKiktl5qZm7jEtamgwCMwKKi2yfB6mRcpX/Lc0AigPzhjr2QLYLPi/rICYidgGpBK/SFl/AD/y97EVGk/F06jjEIv4++yli43naHsxNw9F9fiil7Ue8Rf5+kTewvXeBWBYTUnxzF8jWjHwDX+F3oM3Z/wuax9hKmwVlij73OPfKuSccORKz7A62+/Z7HZe/fKYz3euOutSwRIozUCG4zb/c+lOMldmqFinEZr+mMls684ZC4rx1nLSSOGObAx6O/CFUx57ggGz/jtb7JpOUwwJAJNW9/ihXXA1Nbd7eUPbtoAGA2Htzmfs5JW2raZXweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
Received: from PH0PR08MB7889.namprd08.prod.outlook.com (2603:10b6:510:114::11)
 by DM6PR08MB6090.namprd08.prod.outlook.com (2603:10b6:5:111::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 21:52:26 +0000
Received: from PH0PR08MB7889.namprd08.prod.outlook.com
 ([fe80::486:49b8:9b7d:31a4]) by PH0PR08MB7889.namprd08.prod.outlook.com
 ([fe80::486:49b8:9b7d:31a4%6]) with mapi id 15.20.5038.031; Thu, 10 Mar 2022
 21:52:26 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>
CC:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "song@kernel.org" <song@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: RE: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Topic: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Index: AQHYM215J7vyu92RTE+HlI5mLBGPkay4fs0AgAALUQCAAG5ngIAABaCAgAAGyQCAACIXwA==
Date:   Thu, 10 Mar 2022 21:52:26 +0000
Message-ID: <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
 <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
In-Reply-To: <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2022-03-10T21:36:44Z;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=52f5eaa8-df6e-4627-93da-eacb75075812;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=3
msip_label_37874100-6000-43b6-a204-2d77792600b9_enabled: true
msip_label_37874100-6000-43b6-a204-2d77792600b9_setdate: 2022-03-10T21:52:23Z
msip_label_37874100-6000-43b6-a204-2d77792600b9_method: Standard
msip_label_37874100-6000-43b6-a204-2d77792600b9_name: Confidential
msip_label_37874100-6000-43b6-a204-2d77792600b9_siteid: f38a5ecd-2813-4862-b11b-ac1d563c806f
msip_label_37874100-6000-43b6-a204-2d77792600b9_actionid: 7aed9a78-848b-4af9-9b58-de29ec95cec1
msip_label_37874100-6000-43b6-a204-2d77792600b9_contentbits: 0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cee8f6a-d76f-4665-15f9-08da02e04406
x-ms-traffictypediagnostic: DM6PR08MB6090:EE_
x-microsoft-antispam-prvs: <DM6PR08MB60903B368CEF3F02F2B0DEC8DB0B9@DM6PR08MB6090.namprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kLZhOCgpXbh8Esj4TthwqGZD8YFPcVporeeLlJhelL6IDArSbc+uTKvx3J/rvQZjeB0oIQsuSX8Q28U5DELj0X4OabliHthdlgdg6nkzAe+fTe94AyvbFLYGQUBOmfc6PbY7l3N11roT5QXefoaCqq5ld9tolJ1e8UdV/yXsIiFd6kuUafPVK9KlkmX/bN+ZPEkXxZz1PqwQcS4kCuv6joZXfSc+Xg9DHq/NyV08thDe4iQ72NtZ1va6ZrT/NJRqNFzKECs8KqL3VaFzhdJUEkAEnJ4T6lYBuH8rZ33Pvke6cKe7yD1UiZ1t6R4bqvZVOxFGHpSUAPBJXxfc/v/udjoXhMfCt1UUbqsQGm+M2SBmHuCYJs04wtrOONp2yd5XVIBMyBXanx0HLp0r/xDcjWBZD5tMHPk2O2g2BWa5i+33x3+6hHUFrkdSpAl0l9ZGDFd+mBbfYMe8V/SmfedMaWvVzYPnRlknhDqQdGMy/1D7wI5LXqGGZkCJ4deOZ6BTuxWmY1/ksL5OX569GG9LPSMOStMmRbD9V23YYiZT/P9acS2L7LmwS/ahCPED6aM/l9R9g8IZQtZWAd8hoIgZcyfnBJ3sWOsgXrP4mtkHKfGBU0W2UUZbgphYx4D+62RMaOy3+Kx4v/tigp7yDpJoK4znQz4sC4390IFQMkHGwcam2wnqtdWYXaHo+JyQLY/8+dVatGybNElrrhLPIR7EbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR08MB7889.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(122000001)(38100700002)(186003)(316002)(54906003)(110136005)(71200400001)(66476007)(76116006)(66946007)(508600001)(38070700005)(83380400001)(66556008)(66446008)(64756008)(4326008)(8676002)(9686003)(86362001)(2906002)(33656002)(26005)(5660300002)(8936002)(7696005)(6506007)(7416002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnNUNCtaN1I5a2JMMGpRTzZ5ZjIxL0VoS2gycXFSM1cwcjVaQXFUVVVHN1Fz?=
 =?utf-8?B?ampJcU84SnVoRmlTSnNnY3FRdmhBbVJ1TVNUMCtYVURNNzJsTGUvdlV1Qk9S?=
 =?utf-8?B?NVZ4U0diQXFLRlRncmN6SkVFUDBjaXk0MjM3MWpTaG5GR3kxTno3S0N3ajgv?=
 =?utf-8?B?ZkZ4cjEzN2pMRXJGaGJ2NXZucWh6b1ZpRDlCTkFnRmtEZHQ5Y2t1dm53akFT?=
 =?utf-8?B?aWhDdlFmLzRKamc0Zk1PY2RNSlh1Y0tUbnBKQ3VxY1RnY1lNVHN0cjhTNkpi?=
 =?utf-8?B?Z3NXRG5RSEorSHk0RnNtNzNZVXVEcDFEUW90b1kyZmovTmc2dktnQkNtN2lW?=
 =?utf-8?B?b2F1YmhCQTA0WGdXZUVENzNISUlvNC8yeUJjN1VPcnp5Wi9HclpJdVY1RXVL?=
 =?utf-8?B?d3Qxa3pCMVNvM1hLSy94b0xtWStwQjVoNXpFcDZEYkY3UldONGxkYzlHcngr?=
 =?utf-8?B?UVBHaWx3aWx2ZjJLSWRPNVU0S0I2OEc1VEdWZE83c2s1QkpJNEFSS1NidjNH?=
 =?utf-8?B?M2ZCTi9EcU0raVBsRHVUbzY2czBacHJpUjZBVlZIV2lWaW9WanVRLzBUd0VT?=
 =?utf-8?B?U2JuS0VwSHBxVkE0VTE3cHNXNU41V3FjWGx6OWc1Q0tRclA5aXgrSFNGRitO?=
 =?utf-8?B?eUpzUEpkeXJGSVZqbUVHUFpMb3owaXJtM2hWbFd5c3VyZFlJNmFud0I5UUtF?=
 =?utf-8?B?alNtRmJHK2tiQ1NaSkdNczArdUdCNnlwRWlldU04ODRid05hdWxZRC9POG93?=
 =?utf-8?B?SENNSlVuUTJXSGNvVExDN25oWW5qRU4vV2pKaExrMGYyNlo5bWg4Z3BKVGtu?=
 =?utf-8?B?TC9sTGY3UEE3WEd3VFRRTWdVcTZRcG1tT04yTFFNaitkZk1reWhvVVNPQ0Jh?=
 =?utf-8?B?VWdjWlN6K2Q0UWUxUWwvNkZPUk5oRkRJV2sybkhhYzQ5SVlOU2pHeHNXQUY0?=
 =?utf-8?B?L0hHMXF5dE1aeDRiaHY3SnpQZ1pZSHVhUDg4eTRwOEp6VTFXOGpyYU8wL3BE?=
 =?utf-8?B?TDVmR1lFSHJ5VW1yRU5wcFAvNHpyQ3RMQnVtbkJSNmlHNVdEVnlnbW81cmt1?=
 =?utf-8?B?aTU4VHNvSC84YkZwWkZtSHUyZXZJODZMbFBnS3FlZG9WY1JObjBISVZpcmhN?=
 =?utf-8?B?TXBrNjMwM3dGOFhQSndwY3pCR2JzK0tlWGgzaGRCNU1XOGVTd2VHdENZMDhE?=
 =?utf-8?B?TFpQNGlwSTY3bFZMd2JjQ0dlWmxnTEdUK01qTWpnTThNWWxzWlRWenhPSnU0?=
 =?utf-8?B?dGJhKzkzcVBhMklyK215UXNPY1ZrKzl4U09DQkRhUXRsVjVLcXdVWXNYUlhQ?=
 =?utf-8?B?b043c3MybEJYMnBjR1VLVEdvWWh6dVRwZ2lyckMzbzM5K2xXaHVucUo1dUxk?=
 =?utf-8?B?bVBiemFVbEVHSnVkMmx6TGQyWU9HT1hQaWduWk9xWU9ucklFWjdmMjE5UzRw?=
 =?utf-8?B?aFNURXMwN2FrbUV5ajF1R0kzMUtnalNTa2lKbnFYWFA2eFROV1dXMjlvKzRX?=
 =?utf-8?B?dmg5QmUrYytVekpyaDNiU01hblVDS3R6SUl6MmlZZlNxeS9ndml3Mjl2S3R0?=
 =?utf-8?B?ZDBGTWM2TTdKM21DdCtNMmxsZWFjOStkT3hwVjZ0V1BTcjRtMUhGaEhDMlpx?=
 =?utf-8?B?UHlPaGthbjBxbWJqV2JaU3JzSmRQcThWK3c5MUpLOTNaTExQV1BWelRrL054?=
 =?utf-8?B?S1dCT09ReDRnWng2eDRHRzV3TmFjRWdoa0RXaGRVdEhBSTFMdVRSUTEzTGdw?=
 =?utf-8?B?dzcrRjBHbG1aZmhPbWlycEV2ZFJ2ZFBxenFmemRuWHAyemZGQmY4RVlNemk2?=
 =?utf-8?B?SytjM1ZXb0tmeEIxbWVNOFpkRnZHRUtHYlROdHk5QUNweWd6QVc3Z25wSG40?=
 =?utf-8?B?T0tHK0xGZWNnYm0zQXBON1BaL0FlOHJ5S0pmMUQ4K0xCbm1mSVBRZFptSTU1?=
 =?utf-8?Q?Im6NYVvItq5h4OArURhQPgmEaaES+Vd+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR08MB7889.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cee8f6a-d76f-4665-15f9-08da02e04406
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 21:52:26.2120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3sz5ITlPe3o8/drIAgPrU4A/xLwvQYq0LQIxkNWvE7McJ5krA0kEfhWKj+akyfbhE6hRHEHeUyzTYP18f5LKZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB6090
X-Proofpoint-GUID: X8MsiqV1gcyq3h1OwMvXoUdmAV8GFW9P
X-Proofpoint-ORIG-GUID: X8MsiqV1gcyq3h1OwMvXoUdmAV8GFW9P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TWljcm9uIENvbmZpZGVudGlhbA0KDQo+ID4+DQo+ID4+Pg0KPiA+Pj4gWW91IGRvIGJvdGggcmVh
bGl6ZSB0aGF0IHRoaXMgaXMganVzdCB0aGUgZmlsZSBzcGVjaWZpYyBoaW50PyBJbm9kZQ0KPiA+
Pj4gYmFzZWQgaGludHMgd2lsbCBzdGlsbCB3b3JrIGZpbmUgZm9yIFVGUy4NCj4gPj4+DQo+ID4+
PiAtLQ0KPiA+Pj4gSmVucyBBeGJvZQ0KPiA+Pg0KPiA+PiBKZW5zLA0KPiA+Pg0KPiA+PiBUaGFu
a3MgZm9yIHRoaXMgcmVwbHkuDQo+ID4+DQo+ID4+IFRoaXMgd2hvbGUgcGF0Y2ggc2VyaWVzIHJl
bW92ZXMgc3VwcG9ydCBmb3IgcGVyLWJpbyB3cml0ZV9oaW50Lg0KPiA+PiBXaXRob3V0IGJpbyB3
cml0ZV9oaW50LCBGMkZTIHdvbid0IGJlIGFibGUgdG8gY2FzY2FkZSBIb3QvV2FybS9Db2xkDQo+
ID4+IGluZm9ybWF0aW9uIHRvIFNDU0kgLyBVRlMgZHJpdmVyLg0KPiA+Pg0KPiA+PiBUaGlzIGlz
IG15IGN1cnJlbnQgdW5kZXJzdGFuZGluZy4gSSBtaWdodCBiZSB3cm9uZyBidXQgSSBkb24ndCB0
aGluaw0KPiA+PiB3ZSBBcmUgY29uY2VybmVkIHdpdGggaW5vZGUgaGludCAoYXMgd2VsbCBhcyBm
aWxlIGhpbnRzKS4NCj4gPg0KPiA+IEJ1dCB1ZnMvc2NzaSBkb2Vzbid0IHVzZSBpdCBpbiBtYWlu
bGluZSwgYXMgZmFyIGFzIEkgY2FuIHRlbGwuIFNvIGhvdw0KPiA+IGRvZXMgdGhhdCB3b3JrPw0K
PiANCj4gSGkgTHVjYSwNCj4gDQo+IEknbSBub3QgYXdhcmUgb2YgYW55IEFuZHJvaWQgYnJhbmNo
IG9uIHdoaWNoIHRoZSBVRlMgZHJpdmVyIG9yIHRoZSBTQ1NJIGNvcmUNCj4gdXNlcyBiaV93cml0
ZV9oaW50IG9yIHRoZSBzdHJ1Y3QgcmVxdWVzdCB3cml0ZV9oaW50IG1lbWJlci4gRGlkIEkgcGVy
aGFwcw0KPiBvdmVybG9vayBzb21ldGhpbmc/DQo+IA0KPiBUaGFua3MsDQo+IA0KDQoNCkJhcnQs
DQoNClllcywgaW4gdXBzdHJlYW0gbGludXggYW5kIHVwc3RyZWFtIGFuZHJvaWQsIHRoZXJlIGlz
IG5vIHN1Y2ggY29kZS4gQnV0IGFzIHdlIGtub3csDQptb2JpbGUgY3VzdG9tZXJzIGhhdmUgdXNl
ZCBiaW8tPmJpX3dyaXRlX2hpbnQgaW4gdGhlaXIgcHJvZHVjdHMgZm9yIHllYXJzLiBBbmQgdGhl
DQpncm91cCBJRCBpcyBzZXQgYWNjb3JkaW5nIHRvIGJpby0+Ymlfd3JpdGVfaGludCBiZWZvcmUg
cGFzc2luZyB0aGUgQ0RCIHRvIFVGUy4NCg0KDQoJbHJicCA9ICZoYmEtPmxyYlt0YWddOw0KIA0K
ICAgICAgICAgICAgICBXQVJOX09OKGxyYnAtPmNtZCk7DQogICAgICAgICAgICAgKyBpZihjbWQt
PmNtbmRbMF0gPT0gV1JJVEVfMTApDQogICAgICAgICAgICAgICt7DQogICAgICAgICAgICAgICAg
KyAgICAgICAgICAgICBjbWQtPmNtbmRbNl0gPSAoMHgxZiYgY21kLT5yZXF1ZXN0LT5iaW8tPmJp
X3dyaXRlX2hpbnQpOw0KICAgICAgICAgICAgICArfSAgICAgICAgICAgICANCiAgICAgICAgICAg
ICAgbHJicC0+Y21kID0gY21kOw0KICAgICAgICAgICAgICBscmJwLT5zZW5zZV9idWZmbGVuID0g
VUZTX1NFTlNFX1NJWkU7DQogICAgICAgICAgICAgIGxyYnAtPnNlbnNlX2J1ZmZlciA9IGNtZC0+
c2Vuc2VfYnVmZmVyOw0KDQpJIGRvbid0IGtub3cgd2h5IHRoZXkgZG9uJ3QgcHVzaCB0aGVzZSBj
aGFuZ2VzIHRvIHRoZSBjb21tdW5pdHksIG1heWJlDQppdCdzIGJlY2F1c2UgY2hhbmdlcyBhY3Jv
c3MgdGhlIGZpbGUgc3lzdGVtIGFuZCBibG9jayBsYXllcnMgYXJlIHVuYWNjZXB0YWJsZSB0byB0
aGUNCmJsb2NrIGxheWVyIGFuZCBGUy4gYnV0IGZvciBzdXJlIHdlIHNob3VsZCBub3cgd2FybiB0
aGVtIHRvIHB1c2ggdG8gdGhlDQpjb21tdW5pdHkgYXMgc29vbiBhcyBwb3NzaWJsZS4gDQoNCkJl
YW4NCg0KDQoNCk1pY3JvbiBDb25maWRlbnRpYWwNCg==
