Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C114DC348
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 10:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiCQJtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 05:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiCQJtD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:49:03 -0400
Received: from mx04.melco.co.jp (mx04.melco.co.jp [192.218.140.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722A81D7DA5;
        Thu, 17 Mar 2022 02:47:45 -0700 (PDT)
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id 4KK2PX3hfpzMvyX0;
        Thu, 17 Mar 2022 18:47:44 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 4KK2PX3GgSzMrCxp;
        Thu, 17 Mar 2022 18:47:44 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr04.melco.co.jp (Postfix) with ESMTP id 4KK2PX2xb2zMvr25;
        Thu, 17 Mar 2022 18:47:44 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 4KK2PX2r7Dz6tCP;
        Thu, 17 Mar 2022 18:47:44 +0900 (JST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (unknown [104.47.23.172])
        by mf03.melco.co.jp (Postfix) with ESMTP id 4KK2PX2hHhzMstpp;
        Thu, 17 Mar 2022 18:47:44 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVXyN/9RFW6qPFxdJhhyYJniZkXzCDmPePhoeZU5iyUFAVs7P6Napr+TdQC7dfjV1/3f7VRx4b3sR7m5SbcvlnNw+KLL7cyKJrfV2mG+5ePdrtILpVyjIHvvSMA3OWMdcGhuphx4pTZN3Tf/QTSoRCXv4gnf/o81+bXgluXKTf9cXS7ZTUlqjL1t1FdLYhsHl/qFkuZmv4wJPo8AiK6W44dlR/aUsJM0+E72P+XUrmk2Mywne+BvUtbK2HQ9JJhAuoPAkKWki4nEGt4SVAZK5DNWPQ25TqsfTKX6uxMeR2buQRqtD7G7AvsCxup0at1bZEBvZXSs9JLckSZdPYcOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGTRrILzlQZfWzzCwE0Tv8y0v93QxsEMf0NV8IB6hxg=;
 b=NEUamXNUUN6DtaOZ/4OjzXbCqVGrbOSlb+e/yAXvhUwvX0wk5qwPvsJSdXpplHR3mgACbPukDeMFN1WN17RxjMtbgq5FTcYo8avf7Xrm3Q+etZKC68VDxnFzsXdvq7PQKIMzyPSyTeH0DvZFQnS4xJLSHiwC9J/M799MXejdXxLkMz2pJM4oL2z8xHL0jtFiRKULeCcwS2IVNidjGtTDV0bquUw0Y07BQodo06kRc/3emOLP0gF0xnSAq/eS+nG/ZGw1fDBPxBfrxSZa2qTWB8+KGJTEZfjLbaNT7UEx1OXkpEy+TX2U5V5tJziKqjSgaRR1rt4Em6mFglhzsRpXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGTRrILzlQZfWzzCwE0Tv8y0v93QxsEMf0NV8IB6hxg=;
 b=iHflNW7CULBK+lPuh6WKsivCrbxvA2H5ps6Tqvz1hi5/bnYgyi+a16Y70xjXgM0YZ89Qghlf9h9yHlKPz7vpafTXWN3hJ52V8cXTjeW3078UUxOaxaRsn7Xr+d5JFxxoqD5uCNFwQ4z/vVKjZpsIavwRCzxKee6MHp+VGjzqVzA=
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com (2603:1096:404:803d::8)
 by TYAPR01MB2367.jpnprd01.prod.outlook.com (2603:1096:404:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 09:47:42 +0000
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::493e:4ed3:1705:ee86]) by TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::493e:4ed3:1705:ee86%2]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 09:47:42 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        Namjae Jeon <linkinjeon@kernel.org>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: Re: [PATCH v2] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH v2] exfat: do not clear VolumeDirty in writeback
Thread-Index: Adg0Vskc+T+8E+65Sm+jIEZBsmb4mgAqgpIBAL5OAAAARKJNoAA1uDUS
Date:   Thu, 17 Mar 2022 09:47:42 +0000
Message-ID: <TYAPR01MB5353C2C84F4006C2BEE20DC090129@TYAPR01MB5353.jpnprd01.prod.outlook.com>
References: <HK2PR04MB3891D1D0AFAD9CA98B67706B810B9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <TYAPR01MB5353A452BE48880A1D4778B5900C9@TYAPR01MB5353.jpnprd01.prod.outlook.com>
 <CAKYAXd9BO1LipYx1EtOK=Uo11dY3beBc_0mh_t=opWXPibutBQ@mail.gmail.com>
 <HK2PR04MB389107EDB293B91E9750CEEE81119@HK2PR04MB3891.apcprd04.prod.outlook.com>
In-Reply-To: <HK2PR04MB389107EDB293B91E9750CEEE81119@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 1e844303-d81c-f841-f417-3ca11b29e18d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dc.MitsubishiElectric.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84707fd1-7faa-434c-a3dd-08da07fb2ec0
x-ms-traffictypediagnostic: TYAPR01MB2367:EE_
x-microsoft-antispam-prvs: <TYAPR01MB2367917F463C9A4FBB76095790129@TYAPR01MB2367.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1P8zze68Hl7lGVPJnhgGiXXc2xYSU0PCcuZnsBwGAsFI5d01Q8GfUP/oBlcxw9T6WkEP9AelmygALZp1nDZfn51pkMq80TktpGESsHA1VQ9ZzgObNZS5MfxQLqvo0n64vmJzUt8ttDaO2OYFtHKtj9dofOiwKomrHZkD/MYJXQ8J3IGpKrjcuNRj2fulFQKhdeXDRi7nzauTkhsK8BxbWXr7B7VSD2NRoVBP45NgmaJmCmLNJYT1GpU3jYBskDMr6suCSI1D1dsdInmEjGFeIVFy497LcBxx45lD+YaW/6uvq3YFJBjCfZYKjJQErQRh7WphSG4OK7PCHiw7t+BG3epJl/axsUNKWIRPxC3S25DsG6119gYOnEgfcFgmtH0lVSvWgCh4UuuZn5jRRDcTpQz6XSDAR+rWw0/TcaFH7Tzc7QtDgMMelDRdixQ4ZXbG9kN7aWex+5Ru/rBI6NN3QnI14S6LDqUzyGbDrVQpvqjODiTTdaHsSAMfSSCVuLW0Xd5bp2HwNk/Z3xMj1XC13Hvw68wG2DIeQykkLmX4/7ZK0vPeCz416LYRvUU4A/+t6+BToX5lyyOQTAEkErLV+HMcYpnTILaNfo+BsUhhQgbdd4V24LLTV7oBh2J6H5DT0A16H8TjGvEtVbUYzdn1EszgN5EU35hgeB5mbxITyWJTTUXQW/XOHNGvqjfx+8Fg0HIOik+nTDeUWnA2YgIuWfE2/q8oHaEfAojixnTpJVcy9Mu00nDfRkyEsSl5QXt0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5353.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(316002)(110136005)(6506007)(7696005)(54906003)(5660300002)(33656002)(38070700005)(66446008)(64756008)(9686003)(66946007)(8676002)(38100700002)(4326008)(66476007)(66556008)(91956017)(55016003)(71200400001)(76116006)(508600001)(86362001)(4744005)(186003)(8936002)(2906002)(83380400001)(52536014)(95630200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?emNhV3FHSHNsUTlWVWozT3F5TWNlL3lLa1hJcm1JbUMwVWhqOTM5dS83?=
 =?iso-2022-jp?B?UUZ6SGZGTTFKcHJXYnZUYzd6YUlHUlhMT1B6ZmtIcTAyczVjNmZNaXd0?=
 =?iso-2022-jp?B?QlNFR0ZHT3VkYlZvSmVSQnFsWld4OGV3WTd4WXRuV0E3eXAxZHRLU2xh?=
 =?iso-2022-jp?B?S1hWbWhOek5RK3FlMkRxMlBrdG5RWmZrTDdRRVJoOUdESDNqWi9aTmRF?=
 =?iso-2022-jp?B?L1luWkZrNDllaG1lQlNCWUkyT01IaEhUdEVrdUliazVhSitpMnJYVHBa?=
 =?iso-2022-jp?B?b0RtaFlkVVBWV05BeVdtZDdZNE1CSGRGYS9ZZGgrelh6TS9yc0lxWEtQ?=
 =?iso-2022-jp?B?NkhSK2pxbXJoTG5RWUpVN25OQlFpVEdGaUZVVFU2c0Q1ajZCS3pWeEJE?=
 =?iso-2022-jp?B?b1c2ZGZDSmlKMEFIRUFvbGFKK1FQK2Q4YzFSSGFBaVdkbU9oVjViZ3Aw?=
 =?iso-2022-jp?B?bmNWbnJZN0xyUVBCN09zSVp4R2txeUs4RlhZUUV6S2xaSUFFVC8wdnBB?=
 =?iso-2022-jp?B?WXRScHM3Q0NTZ0ZBTDB0SGRNbCs1bThBbVp3ZG5lKzBwWm9SVnVxMDN0?=
 =?iso-2022-jp?B?Qm43MTZYZHdwZWNaczN5djRkVUNUdjQyWml0cGlRUGl2c2dNT1A1Wis1?=
 =?iso-2022-jp?B?a1F4ZEhISXFINFltRnI1Z3krTVdJSlgxUUxBcHZROUpMY1VxNkJYYlpT?=
 =?iso-2022-jp?B?TTZDaFVXZEhtbUEvaHk5ZzJNd0FMWU9XZEdTMVpYQmdaVkt1R1hwUUFC?=
 =?iso-2022-jp?B?UjVITEVWK2lGMTIwaWFwWjZLQXdTTjM3UTNlQUI1RXMrTEc4NFpQa2c5?=
 =?iso-2022-jp?B?WjFjZUJFR2dSNFMwbzh6dkd6eGVBNlYvTDJnb1hsU2Vsc0IrM29KTjM0?=
 =?iso-2022-jp?B?YUptdldzM1B4UFRsTW94cCsvbGhzSjN0MUxUZHhIdW1kWFFDRkI2dk1q?=
 =?iso-2022-jp?B?UDB1dTF2cHFjb1BlaHZKQ0tjNDVKVC9zZ0t5c1NBbTk3RStyRThJMk0y?=
 =?iso-2022-jp?B?TGp6UHBVQkU1M0Jwbm41MklnSDlqRjVxRUFkRGpVc0pJd1VoNDJnQnNt?=
 =?iso-2022-jp?B?NWYxNUJnUmJDZnBHUmg3aVdCWElXNWo3OVh5M2RQcnpONHJNSzRDK0p1?=
 =?iso-2022-jp?B?Q24rNngycFpYdWRLRGZYZVhqQ0QwMG1FbDdDYmNEOXNSSTRLaXQ0T2tT?=
 =?iso-2022-jp?B?UkVTZUc4TTRiblpzZ3pXUk1lYllmUzJ4cUJIQmZMdFJ0Mi91ZjFUTDhs?=
 =?iso-2022-jp?B?Z0hWY25WTmVBLzQ2UjI0dFo2N29Ubmo1VThwZmo1VzREWVBjRnVzT2ZE?=
 =?iso-2022-jp?B?Q3JweHg3bEdLd2V6aGlubTlQWEpERFVJTkxtWkNTTHA4V0l3V3pJUlVL?=
 =?iso-2022-jp?B?UWtTNjc0TjIrT2hjNlJrNEV2SXdkMDRjM1VGMnkwVlF5TWU3QTIyN2FQ?=
 =?iso-2022-jp?B?bmhqMCtoSjUzV3B5dTVzQlloTW5CcWFqeFZ2dXpQS0dyVDFTREJ3STVk?=
 =?iso-2022-jp?B?NTU3eHNtbWYxL2IrT1RTcjFYUzBLdHdweG9NT1lQNXplaFp0eUZGRTFF?=
 =?iso-2022-jp?B?TUFFZWxQK0FlV3NKOFBjbGhFaGk2VHprc1JhZTFpa0xOSmhVM2VUY1NX?=
 =?iso-2022-jp?B?U1dSZ0VuM0orUXRvVEVwbERCL0JFZkQ2c2FCdURBLzVNMXE1Rithazh4?=
 =?iso-2022-jp?B?d05WVWhSRWwySlc3K1VuSzBqVFdaWXZ1b0g3Ylc3Wm9HdzE0a0Z0TDBI?=
 =?iso-2022-jp?B?VVlJNVZzcnFDY29wZmJOeFdxTXZhYXcxWHFHWFBOM01ucDE1eVk2N1c1?=
 =?iso-2022-jp?B?bFpFSmNGNk5EVHMxbER3OURrTVZuQW42akVFbVNnMi9SSFFYTlB0MDMy?=
 =?iso-2022-jp?B?ZjRoc1NzcjRpc25YNHk3YWNBSU82eENvN1FkSytvT0NxUFFBWGVBVUFX?=
 =?iso-2022-jp?B?MXNGbytycWFBalR2MjRxbTZaakROdTRhOFgweUZtK1RsbmFXbHBPSVpY?=
 =?iso-2022-jp?B?N3dwWHZ6a2hGT3hkTnZOOFNFamZhTXpRZHFpNE84RnNmWlhidmRkL3Fo?=
 =?iso-2022-jp?B?V3QxYVJjZS9ycGlIcWZnaUVmbWFWMmpXWVJ1TmMrSDVzdWp2T1oxZ1k5?=
 =?iso-2022-jp?B?VWxFeHlKZFZkODlPUWwvQkk2UmJhUFFYN0tRbUlkRmpRNUdHMHdjaWJZ?=
 =?iso-2022-jp?B?VVV5OFA5eTUzZUhJUWlmWTYrL2JUb3RK?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5353.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84707fd1-7faa-434c-a3dd-08da07fb2ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 09:47:42.8116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egTDhGywEx2NQFFRODerLKBeHW2N0+Tm4IYWKJ13EC5yJMxAromZPmCqnTFp03+A6cBieM9WE949fDQe0WVRqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2367
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Yuezhang.Mo=0A=
=0A=
> exfat_clear_volume_dirty() is only called in sync or umount context.=0A=
> In sync or umount context, all requests will be issued with REQ_SYNC rega=
rdless of whether REQ_SYNC is=0A=
> set when submitting buffer.=0A=
> =0A=
> And since the request of set VolumeDirty is issued with REQ_SYNC. So for =
simplicity, call sync_dirty_buffer()=0A=
> unconditionally.=0A=
=0A=
REQ_FUA and REQ_PREFLUSH may not make much sense on SD cards or USB sticks.=
=0A=
However, the behavior of SCSI/ATAPI type devices with lazy write cache is=
=0A=
 - Issue the SYNCHRONIZE_CACHE command to write all the data to the medium.=
=0A=
 - Issue a WRITE command with FORCE_UNIT_ACCESS (device does not use write =
cache) for the boot sector.=0A=
This guarantees a strict write order.=0A=
=0A=
BR=0A=
T.Kohada=0A=
