Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF5C4DC268
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 10:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiCQJQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 05:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiCQJQV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:16:21 -0400
Received: from mx05.melco.co.jp (mx05.melco.co.jp [192.218.140.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB8100769;
        Thu, 17 Mar 2022 02:15:05 -0700 (PDT)
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id 4KK1gq2lRlzMw5jh;
        Thu, 17 Mar 2022 18:15:03 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 4KK1gq2LSdzN0W82;
        Thu, 17 Mar 2022 18:15:03 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr05.melco.co.jp (Postfix) with ESMTP id 4KK1gq21YszMs9gF;
        Thu, 17 Mar 2022 18:15:03 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 4KK1gq1vszzMr4pj;
        Thu, 17 Mar 2022 18:15:03 +0900 (JST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (unknown [104.47.23.169])
        by mf04.melco.co.jp (Postfix) with ESMTP id 4KK1gq1gbzzMr4p5;
        Thu, 17 Mar 2022 18:15:03 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwaGRSMUths5DswxyeYOy2gZRPdU2onB4v5XzC9yLMTIJeS/W+egCa1DAIffZlEslv0OSOUFgQA9J2pzAX0UXc3XCFYaALJZt+RuX1C1nEJEqFf7IB+9mSaDB8v6LRZ2GBJtS4fcZ8tqHMtbFrA3vE6La+PdfdqlzREAzUGHcBZf8GHfgWdTgdotSqiKEZCY9zqjuZQBAvPO54vivpIFFSpql2YRCjnQDGQuMFE7OsrLQ0GUDtag4xVjALkdFhrP0B+IdZG4hCO1dO9dZClP49IoF4+K8ZaVBth4Y0gTueytjXulmHuH65/h+uW6Gk1fKBFXHnGFYI19Df+LhzX8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUWFg0NA4yWpKmk7Vv5P32dcMUuLfP5QvRPn5FNkTz8=;
 b=Iqy/CQ63nlvTjTzNWaJDBgvJdQ8WWugKqorIvtMhQwPctZ5cIvnAwNZTW4RcG+gdlQOwqVZ413QhpqI5ib8kPLKelw5oTAYYEU15vWgsEZB5uJ1jywVbFS45ylxOU4ftDmnn3x2qE94BFHm8zAxw7milaH0q2F6Qhm4VC8olmAFFxGntoKN6LLPC1nxPZxVKvfFGCPfkNC5mGMnj0kO9P14mqTX18Tvurh+lLFJrWPj92w/GrQqG3banR04pvDP6IvyZ12iNLhayMITrg4f6Dw5fl+p/AsCOLyNTr8W0uJBva4pUbaqt7eOLdA+OBCYwth1iG9WmhsYdrZval7Jezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUWFg0NA4yWpKmk7Vv5P32dcMUuLfP5QvRPn5FNkTz8=;
 b=S4fxWpmZfX2F451wUFohRZTZhEXcQWKGlNlFAEMibLmvDG5HJYTCHqyYuAfrrm5MMBe7wYa5906UVoeUSXMJQRzIiNgSJ/jp8zysTFZZrZnh66X0Hn0iCGpux7jMKEgecP5S1K1QuYQisH5HiFkQbZAdrUmyBd9nt0ODRzsasXA=
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com (2603:1096:404:803d::8)
 by OSAPR01MB2401.jpnprd01.prod.outlook.com (2603:1096:603:3a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 09:15:02 +0000
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::493e:4ed3:1705:ee86]) by TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::493e:4ed3:1705:ee86%2]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 09:15:02 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     David Disseldorp <ddiss@suse.de>,
        "\"Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp\\\"
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>\"@imap2.suse-dmz.suse.de" 
        <"Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp\" <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>"@imap2.suse-dmz.suse.de>
CC:     'Vasant Karasulli' <vkarasulli@suse.de>,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Takashi Iwai' <tiwai@suse.de>,
        'Namjae Jeon' <linkinjeon@kernel.org>
Subject: Re: [PATCH v2 2/2] exfat currently unconditionally strips trailing
 periods '.' when performing path lookup, but allows them in the filenames
 during file creation. This is done intentionally, loosely following Windows
 behaviour and specifications which ...
Thread-Topic: [PATCH v2 2/2] exfat currently unconditionally strips trailing
 periods '.' when performing path lookup, but allows them in the filenames
 during file creation. This is done intentionally, loosely following Windows
 behaviour and specifications which ...
Thread-Index: AQHYNLplcevRMz/jOUuuvmG0JvLRkKy55GyAgAAFMQCABE5KoIAD1uoAgAFFV0U=
Date:   Thu, 17 Mar 2022 09:15:01 +0000
Message-ID: <TYAPR01MB5353E2F8E11EF7AF3149AA5A90129@TYAPR01MB5353.jpnprd01.prod.outlook.com>
References: <20220310142455.23127-1-vkarasulli@suse.de>
        <20220310142455.23127-3-vkarasulli@suse.de>     <20220310210633.095f0245@suse.de>
        <CAKYAXd_ij3WqJHQZvH458XRwLBtboiJnr-fK0hVPDi_j_8XDZQ@mail.gmail.com>
        <YisU2FA7EBeguwN5@vasant-suse>
        <TYAPR01MB535314A6E1FB0CB1BAD621C2900F9@TYAPR01MB5353.jpnprd01.prod.outlook.com>
 <20220316144546.2da266c3@suse.de>
In-Reply-To: <20220316144546.2da266c3@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: db0871f6-288a-8603-1085-96ead3901986
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dc.MitsubishiElectric.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de947c7e-a677-42dc-7d83-08da07f69e02
x-ms-traffictypediagnostic: OSAPR01MB2401:EE_
x-microsoft-antispam-prvs: <OSAPR01MB2401E6C80AE0E5F81D187C1590129@OSAPR01MB2401.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YzyvfrbNAXtNS2GuecSpMnqMsFrY8K0r9BkByjJU5GjPWVxhjlcJwg3OEh4cyeaffVgxgzKaqMsbsoAkBk4gPz/rQ2sJasXilcUhzOrgUO+IcVjTTC2OC+ZexUH0QkManzCckjrTkOcU9wPr94cjTGe8fVk+POzATMdsRFxSwHboE/c1PR3Bg8HIgQH49rBPYKIUOiEdTF65O8LLQxCeyJXJGaxk4NlCkuCf9esZBNWpwVR70cgCHuVQSZqovtnCn2WWfqe7UJb4iPUwcKJoOYHeh5WXhaTYbjLAywyO8Hrws+qCuoIR9XRrB+G+N6+b8BLCM2pTvPSycpmTLwQIrNQwVnk7isOj5BoqCB+BDXFUJGhBITBsCsD8ZtdmaAVpyiNsQTmikQx3a0IfSKQdjpbu2r3JuIGGjX7xuu4iMyb/4zUoS8xrNT7mO9n8JLJ/Cru0Xul5hXeCNsASiwTinquy2BtJdmqkfBTMQ8W4qDgVw1JZICbEphmGmg7ujamxjJb9WjHnwlR1M5s1waPcXOOjpMuzSRJlXLxe+0th3MZiCzniaki9XRwacB2U9pY+S58BFVkyM5KXqbvlOJbz3L4ja2HwEO1ovdybxWRkJ2pwN7BcsFIyxO0OKN9rpcDBe8YChhLgxs+xkSdolAxlZ6qCBxsIE5ufifQkTiHWRaMs1sIdSpZqIAaNbCRJBwHs8Q9EwQx8SzzCIC9gpUzQqh5EVTV7LhHuGrHIIKyq+LFw8C2UWPHKzu1shn6LoPxmN53OP3guTExJ2gHNqrzyrzox+8gR0eRQqLlokK5Fk2Xzq7QBaGsc5kKEgx7CD64RZvLVGstxWCcne4KAVa0AIeWr4NqPiEycBiL7nqbhC7jE9oZFyo1AnItzQ3hbtQ/Z6lVjnxHG3plwh5xi7EvlJZqQW/IlinUB5bjVFRVslT0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5353.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(8936002)(86362001)(508600001)(4744005)(52536014)(122000001)(83380400001)(186003)(7696005)(7416002)(6506007)(2906002)(9686003)(55016003)(76116006)(91956017)(38100700002)(4326008)(5660300002)(66946007)(316002)(64756008)(66446008)(66556008)(66476007)(8676002)(38070700005)(54906003)(110136005)(966005)(71200400001)(2611002)(219693004)(95630200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Q3c3M1kzVlFmcjlpQkZnZEN5WDhVSmtubHkra0NPT1JFTFcyOHFBRWFi?=
 =?iso-2022-jp?B?WGZveWp3SG9Bc2hqWGJSYiszOWNGNFV4TWlwM0U3S1NjL0RjV0FibkZD?=
 =?iso-2022-jp?B?YmJjaEtGMDBjZlVUckNYZ1BET1Z2czBCYkl0T2grWUtOVEg0TWtwWTJF?=
 =?iso-2022-jp?B?c3U3SG9BWllqUHRpTE5rUHN3L21zd3pkU2ZCU2ZxYTZqV1ppN01oSlp2?=
 =?iso-2022-jp?B?UnV5cllmRTBTbFdOZVlHWSs1N3E1N2lnZzdReWRwckoweFp5QlJWcm5N?=
 =?iso-2022-jp?B?aE9aM3dnT3VmSEcrdlcyYVNJMU1ZL0tXQ0R6UTh2YU0yckZBaXZPdXcz?=
 =?iso-2022-jp?B?VWFLYWZ6YmtFbkJYTDV5MlB2cXN4NFpRZkE5eUNPTlV4NnRhdzFUb3d2?=
 =?iso-2022-jp?B?Z2ZIdmVHc2NwNHdyK25RZk1WcU9YVUtqQXVDcHM5VFJwSlpncFFiVDJo?=
 =?iso-2022-jp?B?TXRDN08xM3Q0NFk1d0VRL0YwQ1lSZENmVVE5VHdDNmdWNXh2MWRwdXk0?=
 =?iso-2022-jp?B?ZGx6TlNySFNMOFVPSGYyMmxUeXEzNitnNkFDeFA2UkFhQk9TdHZtLzFj?=
 =?iso-2022-jp?B?Y1V1VnR4L2l2S2pVY3ZhSTZUYTVJd3RpL1NPanVHUmZTQWhIYmkrOS92?=
 =?iso-2022-jp?B?ZVZ5YVJrd0F2TW1WMzVrZlJHbWMvdENHTTJETmhmVlZCcGxsUTl1dUhY?=
 =?iso-2022-jp?B?dVFxL1JpdzVqZWlnWVJkYUYxK3JDaHgwV0pjR0xSeUJEY1RqZHNCRGFD?=
 =?iso-2022-jp?B?TkxML0taRWZIbVBOQm1lOVJJVm00TUswY25CK05aRFlSQkhEMlEzcnhD?=
 =?iso-2022-jp?B?YmlvQm5YTXZLRDRhTzZmRFh1MmlEOEoyOTBobkpmMDJ2dkJZVFNkcXQ4?=
 =?iso-2022-jp?B?cGFqajQ5ZUJTM2tZUUg1SkF5WjcrYWE4MmRIVTlEZWpzTndOc2dQbDNa?=
 =?iso-2022-jp?B?STgydWtWNHZUdUt6Mk1uUnFKanZFVitOdDlVZ2xiNEcrSjQ0QnkxOXNs?=
 =?iso-2022-jp?B?cFl0NmMwKzdaZlNGOU9YWDFLQitZaHVqWXlvZnNmVy92MGUyYlFGdE9U?=
 =?iso-2022-jp?B?c1FON05QTGpUY1ZBb0dKeFRXMitOb1hGaXF0ZUVtcllHbDVaNzgyeWNa?=
 =?iso-2022-jp?B?eThRZXV4VnVrZWMwVnFjS1RVOFQrTTJpeFp0elEzUVFCNUgzdkxSTlJa?=
 =?iso-2022-jp?B?Wm9SUkcza0RqaGl5K3NqdTJVeUhYWUtrSWpOWUViL2QwRVpONlFnVC9a?=
 =?iso-2022-jp?B?Tzl0UUJubElMYk1zUVRxV3p4cnAvUVQ1TElmNjE1bzRYaHdTOWVmUmRy?=
 =?iso-2022-jp?B?eDQ2VlZ1M1ZEbVB3QXYzbTdrQWZmNWxuSnMwajBPcnZsTDliRksyS1BC?=
 =?iso-2022-jp?B?RWtXTEtSSFRhTjljZ2NiNEF0Ui9pem9GaWFNNHdqcXYzMnpMaFRQaU5O?=
 =?iso-2022-jp?B?a1NoTWdGSXR1Yk9remR3Z1hXR3Z5WlUrbGg2aUY4TTM0a3hwY2pjQlBs?=
 =?iso-2022-jp?B?OU1HeXN0Yld0c2N0TUt1M3JOQS9UWGhNYU9JUnlMdElRNUhTQ0NVSTlB?=
 =?iso-2022-jp?B?YUUxOG9ObFZmVWluN3pYUFRxenQ5SXhPVWFrS1RkUnB0QXZ3aGIzUWN2?=
 =?iso-2022-jp?B?aG1EUUZUQ05wZ3VEQU1rNU1ZeHI0WFdzOExBcUE0UGhMU0gveEVIVGZR?=
 =?iso-2022-jp?B?eHA0dnJZYlZCSE9STy94NHhuYkNnNU55bE9hMHJ6VXpKU08za1JHcFFl?=
 =?iso-2022-jp?B?MlVzNE51M0hqYmhyVFZDUGI0MHI5b3U1K3k5Yko0RitwaHJ6WXBtR052?=
 =?iso-2022-jp?B?LzcvS3pkNmxKVDB4UGl6Ri9aUng5SHc3aXk0cENESTViVGliTkVOZ1lO?=
 =?iso-2022-jp?B?dm9OVWRyY1dtZWhvM0sxUWtQRTRyWmU3UTRxWmJVY0VlNWVBNENCdHNz?=
 =?iso-2022-jp?B?S0xIcUdlRnNHdy9pRGdtQ1dnb2ZPaUlPWmp0VDZtWmpOMy91c0xXL3Fn?=
 =?iso-2022-jp?B?NHZQYlI1YmE5UjAreUxxaXBCVlowUkRJcUZVSzVCVXdkTDhTbVZ2Zlpy?=
 =?iso-2022-jp?B?VU9KK0Q0K0p1cVpOWmNNUlBBd2o0eUVINlB3MVpNQkQxYSttVnByNGJY?=
 =?iso-2022-jp?B?UXNHekdqdlA5c1lPL092bHhUWGlrd0tsSU1GZmJkbDNER2NmNFpQUlhT?=
 =?iso-2022-jp?B?ekIxaEhoYnRXendWNC9MeFJLTWxxTVR3?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5353.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de947c7e-a677-42dc-7d83-08da07f69e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 09:15:02.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdoL94l/3LJp2OM01fRbFO8zWuQJWrlFsIf89cPzE6TSzXJQmv8cGb78rpRByY6Fz930oqfur+fOqO6j9/RkKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2401
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, David.=0A=
=0A=
Thank you for confirming the actual behavior.=0A=
=0A=
> Please explain how you came to that conclusion.=0A=
> I did some further tests using the win32 CopyFile() API directly[1] on=0A=
> Windows10 and observe that both trailing periods and trailing spaces are=
=0A=
> trimmed for an exfat destination path.=0A=
=0A=
I'm using the native api to investigate the behavior of the filesystem on w=
indows.=0A=
This time, I verified it using NtCreateFile().=0A=
https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/nf-ntif=
s-ntcreatefile=0A=
=0A=
Cygwin and some tools can also create filenames with a trailing dot.=0A=
=0A=
BR=0A=
T.Kohada=
