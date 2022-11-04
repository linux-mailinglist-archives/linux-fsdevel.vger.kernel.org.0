Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B1B6193D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 10:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiKDJrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 05:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiKDJrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:47:22 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FDB178AE
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 02:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667555241; x=1699091241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K2pX8SfZvk7C2oCF5Ia8rYPhXk6vti1hM6js5HphkbA=;
  b=Ms3QX8KWHA4RE/beXi5t3N0TFXEmE++lKtCFuAStJ7HMsav+haFxJT+8
   uzBBG40wnzkz4n/tXj7+8riIp+61FZh2PPT0Cix/8Fu/xw6owo/KHPqR4
   NIieEZqG7cB3cnEPW+Z5LxvG/RpCWqUVhWPN6Y1ucew2JD/Cq7dyzeL14
   /7FFJGMyIQrHKMaL7K02I2pbrJxMEmrfjReVlj0enu3zthBDc7cLfxnK8
   Vxlo3WJn4a6cEgl8NY7lbhWwQo/dQH88X321ToekNXz6seIYkqb612RYd
   jsUbZ47sDttsicC1orgnOmc1p2sLfXUb7bSEjBf16y+FXe2mk6n6FgJyg
   w==;
X-IronPort-AV: E=Sophos;i="5.96,137,1665417600"; 
   d="scan'208";a="213774523"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2022 17:47:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knVXWh0aiTxC/rBZzbiEg3LX8Vxqvp0f+L9VhGfVBl+mWj/SzvkqWb2LwyrnsmzhLkCHORJhvt2EgGSOhy+buIVXNpdAl0f7NLMKqedNOG9nFUkyvgtwE2oxmRS43WwWxGo4ara10HuuvRaDMi0DrpHg4dx/cG6CBHKz1FEmVPEu4xqLH8k2oLKDA5E3jIaknwtP5D/+SsaHawLnBsyArPpqnAzvIzVBAenyp4dqyesg4pqSBAxM7yJMmt7RS25birCqVE57qHQyZ68D+LYGXLY48TioEbBD0TYKmXMWmhGOfmfiFtsrEOy0OOMphalmqus0hq8a3Xdn/AVCookqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2pX8SfZvk7C2oCF5Ia8rYPhXk6vti1hM6js5HphkbA=;
 b=T0FqT0yJVdUmsFp79pWGPY8RMieooptU+INsaJDo1pYKr6Bnc0BeHHKQz0uW5QVE3nnQo6OmSSFz8u2vos1szsWIwgCsSAAWU+1r65HFfGLGcQXTQa9dr6bttOXzJ6YHQUwgPqYhy4tAKP0hrmcNPjDfjKK2yEMiDfUaANQ+U9p1PkGQVZX8+H6Vbjq5xYLojkhcLMmUNqtaQfjQNMQMbxIhy3Fi3rbL6aowW7O/efmlcQ4TfGYDYql92q07mLjsYl8thKk7OZ+KNf7aZfOullnZKHFxm/HjMkOPI7SPF6AsKz7gdq6n/gYd1yTvAc32/IDstaBWq1MaaYviiZH4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2pX8SfZvk7C2oCF5Ia8rYPhXk6vti1hM6js5HphkbA=;
 b=SjZ78qBY1gvvl8cbzjRp6uupu9rgkUiwK1fOgR5RZg9H0w7RriwpZZ9HB73EGxAjLGSF1GxoUmx3AtQPIYhoriRdgNowN4gumzk5Ty93S32mrAXQWsdQ9kNnDPrbJQ0HA74JxS1t6eUXFMWohVv3R+BNqz6CqW/pDjaNlUQQKOY=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7502.namprd04.prod.outlook.com (2603:10b6:a03:324::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 09:47:16 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::307b:ed13:1276:2d97]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::307b:ed13:1276:2d97%4]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 09:47:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: add sanity check for aggregated conventional
 zones
Thread-Topic: [PATCH] zonefs: add sanity check for aggregated conventional
 zones
Thread-Index: AQHY72+Xy/lTG5532kytK/TEjg0Lya4t6U4AgACcp4A=
Date:   Fri, 4 Nov 2022 09:47:16 +0000
Message-ID: <86c97181-fcd5-8e8d-9b20-b7fc2e74c8fe@wdc.com>
References: <f7e4afaca0eb337bf18231358b7e764d4cdf5c5a.1667471410.git.johannes.thumshirn@wdc.com>
 <085f1e1f-0810-1850-44d0-2704250799a3@opensource.wdc.com>
In-Reply-To: <085f1e1f-0810-1850-44d0-2704250799a3@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB7502:EE_
x-ms-office365-filtering-correlation-id: 2b5b027a-7e7c-45fd-cbb0-08dabe498eb5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6FnpK5raiO8cSvR+KMWYtbihK0esj2iC/Ws4F7eWA2Xk+TBkLoWLrVmArpMY/OmUN5NSlEI+UdUYEi7WeDDuPGw0VPogBV7WSZ/GvNYnvmYyYWSI+ZFFJiWPsnGOM/Y1ckj2O4or+Hmow/61s8gCeho+6u7iT3yczpg/v5c3vSjJoAgoNdeDbMn9JkEstDxj+qPRgRKx4br6SzboW74EGT/u1IdVX3iypy5yYiSVaM56zylswuuRxWRhwWEPr2uxwiPWJPs0jSKT9vZRsUR63ZHrHCXgxfamM1fzOnktJus6M67mLjK1tFVmCHDS3EJALFWBn8Ua1YF2tRNkVAkiuF89oXITPj5M3EzPyz+s3Bk8el8hhQleKAQ9/vDjy5fbGCYc68SaLuivmKURfLZ+FLIcw+aQqFngOzgfwADamg1hGZ9d0pQtTggr2inpeByPimAE4uXuWkc4qq2XkrKdC+TsLVpsdaduJcY1OOjRHX9JLocMMlFn6xwzed0I0IAlyw2fbmhvlO9DqLcYnO0hDhZRa6cvwwbDp3qQYgNlQ5xe7lwqi6ucxwInn717fydPjXEiR98Eo/umdLvHS414BJK1CY4Tx6rMwxbKGO0FrnxBebHahn8TXAQpKXQADbn3HSuoekn76+oEPlkNKu4Pm/sw2h5x909jbHu/TUEYJU+5cieeJqBCBkEexl+H7demU/FR1oWYeSI6EJffFSi+sjhyHeKo19VN/1aolVKTmk+ygs0Pupi1+A3f83nDzulnXhMuPyKLDyWfRGZr6KoRo6SJYOmZtloAWQFBBuwhTRQdnUPx8OIOm4DRxKYmTb5GCWjepCZ8lC39k2IgFLOGFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199015)(38070700005)(31686004)(5660300002)(186003)(2616005)(71200400001)(478600001)(6486002)(53546011)(91956017)(86362001)(316002)(38100700002)(36756003)(66476007)(66946007)(66556008)(8676002)(64756008)(26005)(66446008)(4326008)(6512007)(76116006)(8936002)(31696002)(6862004)(41300700001)(6506007)(2906002)(83380400001)(82960400001)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUdWVnRGNWJuRjZicUpINXBETWVJa1ovcEF4dGdBVFJ5b0RWeGd3aGFiak1a?=
 =?utf-8?B?RVkrSFhlNmthaDBUQy9ReGo4NkdBeW9pNkF0NXl0Z21NMkM3NGozNHRJVnlI?=
 =?utf-8?B?cjRZZmhQL3pUOVJCeEhLTUc5dkY1RGIrRW5aeG9PVWl4NDFkbUdWS3M2V053?=
 =?utf-8?B?eWsya043MG80WnhRTFFqQXVlR3Q4U2g3OGk5bTVOaXk2MVYrelkvckNyMDNx?=
 =?utf-8?B?ZmU2ZDZnMUEyZk9obWVMK1I3RGQveE04U3RUeEc2QlhvR1VmZkhKcklUMFVk?=
 =?utf-8?B?RGxhVWRXZFZ6RHg4K29HZEhWMlRJcnd4NTlFeHQvZ0doY3AycVhLY254allj?=
 =?utf-8?B?KytGQWlkVUc2eERsd0tjT0lFUkNzcmx4bGxsa0c1UlhKM3o0QU5ZSHFEampC?=
 =?utf-8?B?bUF0Q1ZBSDNSb2ppbmpwU0xGbGc1cUxtbTRRVnh3Ym5USkRidE5RcUlVRllD?=
 =?utf-8?B?U2VSRW1LUFVySHhDbzRDZE9RN0E1UlpEZ3c3bFpYMCtMNUUyaVdYSlQ1d05M?=
 =?utf-8?B?S3hzSDAvWHQrM1FhSVRmcWFncjNNSDE2WGpvVy9jV3oyaThiWWlJL3M1Unht?=
 =?utf-8?B?NXZKRUFKeE8xSU1wN1B3ZXVmN3IyOGIyRm1aWVBRVldKV0s0OGZTb290b1pI?=
 =?utf-8?B?RTNMUndsdm5yOGFtc3ZIcGpla1N6OUpFRG1DOEtqOEJPakxsQi9WUTlSZER0?=
 =?utf-8?B?Z0MzZVI3OURMM0ZjWUg5R2N4VEp6cVVHMUJKTW1PZVFnYzBXNlFvZHBzTGpo?=
 =?utf-8?B?VHUrT29jdnp2L2djU3NzL2ZKY3NZV01vL1VEdmlDS0Z1cEpLWHBhMm9TcmZl?=
 =?utf-8?B?QmY0Z0lQS2ZuUy9vakkyZGhXRHdlNHc1eEg5VFEwQ3JqZlROMEpZZ2hyTm9C?=
 =?utf-8?B?WjJvT1JiNlMwd1hMZHd0UUlZaGRhQUV2c3NCOERTTzlMZ3FRMHE4WERuYXE5?=
 =?utf-8?B?UnRhOVoxYUFRQ1J6WXI0QjJaemoxV1BYV3hFNTNraDBROEsrMHdkaWNiL1hN?=
 =?utf-8?B?WmZBSG01cUxHWVVDZ0JUMzc5ZUtTNDZtRHVCYzc0TXcraGZvL0YrdTduWDlx?=
 =?utf-8?B?WnR3cjJNYmRFLzlPdnV6SFhLaStLOHNVdzZ4eDhtTmdOWWtCVm5aZWRPOFZs?=
 =?utf-8?B?aGUxK3c5bmE5eEhaaCsxT2p3eHNheHdlZjZPYjQ5Qmp2RFp4UytGdlgzTnAr?=
 =?utf-8?B?TUYxMnRRQzVPc0U1YWgrdTkrYUJqK3pVWVdVVlhVb1hmdnhpdEVGUEtzWXZS?=
 =?utf-8?B?ZWlWS1R6NnNvQ3BmcjF3bVJYUU5Fd0hIMzBFWHBkdlNtMDgzNElMZk1CdUNY?=
 =?utf-8?B?Q2I1ZDlnZ2puZnpobDNGR0MrYTNGd0lYVGRrTFIvSGFrWjVhYU5FWW53MlVl?=
 =?utf-8?B?MTVvSkE3Q1BkcWI2VXdxYnFGb0JzcXZiSzJsalZvZFdLRWdNRC9qOWFwUEpx?=
 =?utf-8?B?Y2c1eU04NWkybEpndDJXQ2Z5bllCbGhja1YvYmJxMlRSNWdkUXJJRHd6TzlH?=
 =?utf-8?B?K3Q2NTRnTW5CU2U1TTlxYTlRUUZDbXZtYWNWNmJ0dklXSXB1TkhUZ0Y4QzVo?=
 =?utf-8?B?WUM4RWdHQWIyeWtNYTAycVhRVHN3U1NlZjZBOTlQdnFVYmYyS2thZnlkTkhJ?=
 =?utf-8?B?STFONzhBbWtsWFlXMlQzOVZHOTBmMTI5MFlWOUQ3YlN6dXVJdDZRczJuNmM2?=
 =?utf-8?B?WFNoRTBYTTZWWnRHL0tJT0N2TEt2am52Yno5ajhDcUMxNlREMElQZE9JWjdO?=
 =?utf-8?B?aElDM2hSTWQ5bis4a2x4aUNUbGRkSnlOQ0VIM3N6Q2FLQnV3QzFhaG5uV1kr?=
 =?utf-8?B?dlBVbjRzM1RmRmZzQzl1MktMcXVaSytlQzdXcjFuVnhtNmxkbU52U040QlVD?=
 =?utf-8?B?L05HVlh2K3UvOUZkQTVINE4zeVk0b0RJRmFmeG1ka2lxNkhnQUxLdWpqYzlu?=
 =?utf-8?B?cWlTQm9OUlIzS2VmT3ZubTZXaU5VcWl3UnlvZVZqZ01SdDJvNldmSE9XbWhF?=
 =?utf-8?B?ZHBwY0krbENSSUpJQjd5S2FjYWJpazJMNWppb3R4eENnL1djM2VaTUdrRGM4?=
 =?utf-8?B?anBjRjBNRGd3VkVNUW1aTVp6ZWdENklxL3NtRHNBdDd6dTc5dUlFZWU3eHBq?=
 =?utf-8?B?RS9YU0s5TDVLUytzU1I2Sm9EMUYvVko3WE5vY3JXSmFzcDBjZU9GRWhjNTlH?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A55467BF4535F46AFFA579210AA27EA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5b027a-7e7c-45fd-cbb0-08dabe498eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 09:47:16.2359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6KFRkFxoNjW0L4RqQ2VPY9TiEOtEw4u0fSxMa3SFZjv/3gKOoG80QnJdeUNSkQQhjDiln/aPKn5yal6iIBNblM1FdCtB8GsMW+YdEYjqLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7502
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMDQuMTEuMjIgMDE6MjYsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBPbiAxMS8zLzIyIDE5
OjMyLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBXaGVuIGluaXRpYWxpemluZyBhIGZp
bGUgaW5vZGUsIGNoZWNrIGlmIHRoZSB6b25lJ3Mgc2l6ZSBpZiBiaWdnZXIgdGhhbg0KPj4gdGhl
IG51bWJlciBvZiBkZXZpY2Ugem9uZSBzZWN0b3JzLiBUaGlzIGNhbiBvbmx5IGJlIHRoZSBjYXNl
IGlmIHdlIG1vdW50DQo+PiB0aGUgZmlsZXN5c3RlbSB3aXRoIHRoZSAtb2FnZ3JfY252IG1vdW50
IG9wdGlvbi4NCj4+DQo+PiBFbWl0IGFuIGVycm9yIGluIGNhc2UgdGhpcyBjYXNlIGhhcHBlbnMg
YW5kIGZhaWwgdGhlIG1vdW50Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1z
aGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+PiAtLS0NCj4+ICBmcy96b25lZnMv
c3VwZXIuYyB8IDI3ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFu
Z2VkLCAyMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9mcy96b25lZnMvc3VwZXIuYyBiL2ZzL3pvbmVmcy9zdXBlci5jDQo+PiBpbmRleCA4NjBmMGIx
MDMyYzYuLjYwNTM2NDYzODcyMCAxMDA2NDQNCj4+IC0tLSBhL2ZzL3pvbmVmcy9zdXBlci5jDQo+
PiArKysgYi9mcy96b25lZnMvc3VwZXIuYw0KPj4gQEAgLTE0MDcsNiArMTQwNywxNCBAQCBzdGF0
aWMgaW50IHpvbmVmc19pbml0X2ZpbGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0
IGJsa196b25lICp6b25lLA0KPj4gIAl6aS0+aV96dHlwZSA9IHR5cGU7DQo+PiAgCXppLT5pX3pz
ZWN0b3IgPSB6b25lLT5zdGFydDsNCj4+ICAJemktPmlfem9uZV9zaXplID0gem9uZS0+bGVuIDw8
IFNFQ1RPUl9TSElGVDsNCj4+ICsJaWYgKHppLT5pX3pvbmVfc2l6ZSA+IGJkZXZfem9uZV9zZWN0
b3JzKHNiLT5zX2JkZXYpIDw8IFNFQ1RPUl9TSElGVCAmJg0KPj4gKwkgICAgIXNiaS0+c19mZWF0
dXJlcyAmIFpPTkVGU19GX0FHR1JDTlYpIHsNCj4+ICsJCXpvbmVmc19lcnIoc2IsDQo+PiArCQkJ
ICAgInpvbmUgc2l6ZSAlbGx1IGRvZXNuJ3QgbWF0Y2ggZGV2aWNlJ3Mgem9uZSBzZWN0b3JzICVs
bHVcbiIsDQo+PiArCQkJICAgemktPmlfem9uZV9zaXplLA0KPj4gKwkJCSAgIGJkZXZfem9uZV9z
ZWN0b3JzKHNiLT5zX2JkZXYpIDw8IFNFQ1RPUl9TSElGVCk7DQo+PiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4+ICsJfQ0KPj4gIA0KPj4gIAl6aS0+aV9tYXhfc2l6ZSA9IG1pbl90KGxvZmZfdCwgTUFY
X0xGU19GSUxFU0laRSwNCj4+ICAJCQkgICAgICAgem9uZS0+Y2FwYWNpdHkgPDwgU0VDVE9SX1NI
SUZUKTsNCj4+IEBAIC0xNDg1LDcgKzE0OTMsNyBAQCBzdGF0aWMgc3RydWN0IGRlbnRyeSAqem9u
ZWZzX2NyZWF0ZV9pbm9kZShzdHJ1Y3QgZGVudHJ5ICpwYXJlbnQsDQo+PiAgZHB1dDoNCj4+ICAJ
ZHB1dChkZW50cnkpOw0KPj4gIA0KPj4gLQlyZXR1cm4gTlVMTDsNCj4+ICsJcmV0dXJuIEVSUl9Q
VFIocmV0KTsNCj4+ICB9DQo+PiAgDQo+PiAgc3RydWN0IHpvbmVmc196b25lX2RhdGEgew0KPj4g
QEAgLTE1MDUsNyArMTUxMyw3IEBAIHN0YXRpYyBpbnQgem9uZWZzX2NyZWF0ZV96Z3JvdXAoc3Ry
dWN0IHpvbmVmc196b25lX2RhdGEgKnpkLA0KPj4gIAlzdHJ1Y3QgYmxrX3pvbmUgKnpvbmUsICpu
ZXh0LCAqZW5kOw0KPj4gIAljb25zdCBjaGFyICp6Z3JvdXBfbmFtZTsNCj4+ICAJY2hhciAqZmls
ZV9uYW1lOw0KPj4gLQlzdHJ1Y3QgZGVudHJ5ICpkaXI7DQo+PiArCXN0cnVjdCBkZW50cnkgKmRp
ciwgKnJldDI7DQo+PiAgCXVuc2lnbmVkIGludCBuID0gMDsNCj4+ICAJaW50IHJldDsNCj4+ICAN
Cj4+IEBAIC0xNTIzLDggKzE1MzEsMTEgQEAgc3RhdGljIGludCB6b25lZnNfY3JlYXRlX3pncm91
cChzdHJ1Y3Qgem9uZWZzX3pvbmVfZGF0YSAqemQsDQo+PiAgCQl6Z3JvdXBfbmFtZSA9ICJzZXEi
Ow0KPj4gIA0KPj4gIAlkaXIgPSB6b25lZnNfY3JlYXRlX2lub2RlKHNiLT5zX3Jvb3QsIHpncm91
cF9uYW1lLCBOVUxMLCB0eXBlKTsNCj4+IC0JaWYgKCFkaXIpIHsNCj4+IC0JCXJldCA9IC1FTk9N
RU07DQo+PiArCWlmIChJU19FUlJfT1JfTlVMTChkaXIpKSB7DQo+PiArCQlpZiAoIWRpcikNCj4+
ICsJCQlyZXQgPSAtRU5PTUVNOw0KPiANCj4gSXQgd291bGQgYmUgY2xlYW5lciB0byByZXR1cm4g
RVJSX1BUUigtRU5PTUVNKSBpbnN0ZWFkIG9mIE5VTEwgaW4NCj4gem9uZWZzX2NyZWF0ZV9pbm9k
ZSgpLiBUaGlzIHdheSwgdGhpcyBjYW4gc2ltcGx5IGJlOg0KPiAJCWlmIChJU19FUlIoZGlyKSkg
ew0KPiAJCQlyZXQgPSBQVFJfRVJSKGRpcik7DQo+IAkJCWdvdG8gZnJlZTsNCj4gCQl9DQo+IA0K
PiBBbmQgdGhlIGh1bmsgYmVsb3cgd291bGQgYmUgc2ltaWxhciB0b28uDQo+IA0KDQpBZ3JlZWQs
IEknbGwgdXBkYXRlIHRoZSBwYXRjaC4gT3IgZG8geW91IHdhbnQgdG8gZG8gaXQgd2hlbiBzcXVh
c2hpbmcgaXQNCmludG8geW91ciAiem9uZWZzOiBmaXggem9uZSByZXBvcnQgc2l6ZSBpbiBfX3pv
bmVmc19pb19lcnJvcigpIiBwYXRjaD8NCg0K
