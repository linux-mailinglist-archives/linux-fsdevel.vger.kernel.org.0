Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005E43A63B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 13:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbhFNLQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 07:16:11 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com ([40.107.7.117]:28738
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235449AbhFNLOI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:14:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZdwyrREOLl8uIIAQ41O9BfUwcLbKNNmWhe0+/b3vmRCWRN/IlS9lfw8C/PMa0pRIoe7KO6y+oaWnk4LCsymILzDWClu+tdJNl23hlP/BU+YANeavZxdgv8pVa7Kv56GkZ2PrI/TPoXYdBLokbSlqpOAHT+HBI7f/eYCk/pvNR7Tc+wDoxXirrorxrMKeZHJ5HWt6F5CEsrDxqeFIufPiwYPv7mlOjWoPflEXVbM55kMQ39VCNa2pL56nnsNe2waSy9G2670qbp9M0rNZfHww3W6VXwvaoTMJMRYkOPY9pk8wts73rQvynYwSDbCNPTY47SGl/dFvdebrZM3mp8NNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8fcXJuROxqeInq1RchMCbj7+OLNuyY4zfvnxjiCZ1A=;
 b=W+ryq2LSuZnOH5qUm5TmFXesrBwsBe61zMlEffMJ/X6DhdJPhVwlIo6If5r0Zlv/P1BNyReNe9A06m5Sn9DvnY9iTY9WVEWSzSdfmdXrD0hgGuy+yyHcKxZhpUqMMvGeD8jFpfUnsvhRssYy5nsUkfsU1PmdBDeaqiV358KcyMDkFgIBJo0IYhYoTIvlh9uFjiJz2J8hzP+YWJdOsTc/4iZeoUcrPI1WhPBSSYWv/QkSxtNrGe/nMP4Qw09jixB3rsvF2rp2tgfOnlsS9tPFtPEzS+AknH3b2qys27Vosa1XUt7v/VCoPGGywWFrotJzFFhIWo6yiNap+K1YfQXXsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silk.us; dmarc=pass action=none header.from=silk.us; dkim=pass
 header.d=silk.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KAMINARIO.onmicrosoft.com; s=selector2-KAMINARIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8fcXJuROxqeInq1RchMCbj7+OLNuyY4zfvnxjiCZ1A=;
 b=oXEkV70uoWoE29mQbFvCwScqEFtuCqBR6qAV+uIkayG2Waz7pkPpo5q41pQiF2fyQ5D0osxi36hNtDxRRGPcGrGa8EG1WmPGsJhlg5/ekYkpR6kWK9e+OLQX5iepKMeIfkT16fo1u8mm6WuEsmGQGwBFVzD8SYfy0Tdo8de4pIk=
Received: from AM6PR04MB5639.eurprd04.prod.outlook.com (2603:10a6:20b:ad::22)
 by AM5PR0401MB2657.eurprd04.prod.outlook.com (2603:10a6:203:38::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 11:12:03 +0000
Received: from AM6PR04MB5639.eurprd04.prod.outlook.com
 ([fe80::91d3:83e4:d90:a710]) by AM6PR04MB5639.eurprd04.prod.outlook.com
 ([fe80::91d3:83e4:d90:a710%7]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 11:12:03 +0000
From:   David Mozes <david.mozes@silk.us>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: futex/call -to plist_for_each_entry_safe with head=NULL
Thread-Topic: futex/call -to plist_for_each_entry_safe with head=NULL
Thread-Index: AQHXYE57zRithvFGzkuN4Iof4OaWJKsSXfgAgAD2lgA=
Date:   Mon, 14 Jun 2021 11:12:03 +0000
Message-ID: <AM6PR04MB5639FBD246251DEF694AB02FF1319@AM6PR04MB5639.eurprd04.prod.outlook.com>
References: <AM6PR04MB563958D1E2CA011493F4BCC8F1329@AM6PR04MB5639.eurprd04.prod.outlook.com>
 <YMZkwsa4yQ/SsMW/@casper.infradead.org>
In-Reply-To: <YMZkwsa4yQ/SsMW/@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=silk.us;
x-originating-ip: [80.179.89.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9650d3b3-b6e0-46e5-d8ad-08d92f253d22
x-ms-traffictypediagnostic: AM5PR0401MB2657:
x-microsoft-antispam-prvs: <AM5PR0401MB2657797CA1D25200D25DDAA6F1319@AM5PR0401MB2657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UdeJk3XDcscG9QQwc263vKz0nOC3FK06jPgKrrlAvSMc+ZFQ5A0qmRSV7vgPPGCCBsNl5GRjf8vMeKolqv0OiFNZBkcahP7FOXm+8TIVYt2qqkDJMIb6SH+N2K/lvySSPtSk9gebuTPMAZLJrfFH8Z/gXIerAmFgiHvXivjFtRudVTrq4NMkuhozgcCHNJdEdJIbXenUMnD9usxGRQt/JQUAIMPIz+c3J23w636sKJ5nfh96wLB/XH1fHGEp/EfcfyYOQsMiSsZehqXOcjL7TGRy5l1eTUe57DHJ/Z6vOuk+gDD72A1m0OfUj5tctZmmwdUdL6+rt0nTfJYy1+Mf6Gf08w0gW6QabMN0Co0PWUKtMkvziLIXH6/waLW9JXTikNXq7m648jhzqurKImtOSC3757ZRRlFIaRljd3YJwHO2LmGUo4H8Z66nQVt5QwG6NLGEcjmsoDx0hNEVVBT/2oeInp2tVC4J4dAIH6TRAREd82NmT+fn8Rp72wJDsvRImAB7tPypTUAuUklu5dYQl/VE5rk012vnlh3IioY0+2Zc51rHXLSlZdwPfHGbLNYWsskH9rIekOeKaulbnKt2vC+eA0DGCrGqluTPKOXzfzX+HCoIdrVLU5A7V4N3GSBom6c68GziUS5OkufRdFdBvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5639.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39850400004)(396003)(366004)(316002)(26005)(55016002)(9686003)(186003)(4326008)(122000001)(38100700002)(8676002)(54906003)(2906002)(8936002)(478600001)(66946007)(83380400001)(53546011)(6916009)(6506007)(5660300002)(44832011)(7696005)(86362001)(52536014)(76116006)(45080400002)(33656002)(64756008)(71200400001)(66476007)(66556008)(66446008)(80162007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7CwdztlxTlQ/ksaM/RoulPxnu00LNAemVcJQW4K6ext6xoqyd4KSrseo8L?=
 =?iso-8859-1?Q?snyEeNDQ71EnvCFobq32b5bVqXbE0yjoKfhky6iIyHqij8i84bVL5wwE6P?=
 =?iso-8859-1?Q?KJd+kAyAZ5FhZ1iHwTBaCqmCXtS0KvrDKDOJcQZlIi/8S8GHEzh4/evanF?=
 =?iso-8859-1?Q?/f7f1+lNW8nhf+Gj6PE1PkE7ag6mEKoaX5/UuGprkssGidPxNXmVsL7QEP?=
 =?iso-8859-1?Q?a/96IRpMOzRdVgJa1KbOkJXaaNh9g+hlJL8FAAgGF9LgahUbId2J1i5JkE?=
 =?iso-8859-1?Q?MbawUvsPn7WVozMPKP+d9+SU6IEJ9EjwogC09TEcl8cuVjj0W+Y7EsWAlI?=
 =?iso-8859-1?Q?4CrW8+WvaaEpRu1iWK5kktIRckQI3Wt4aE2KHcjxoL4AwgAb4ZuX+8V9A+?=
 =?iso-8859-1?Q?TKmR3juYVbJZTHqI/CUkl7/dfGNNZTCppCA8KAEZ7CFGdX+O+4bujSqODY?=
 =?iso-8859-1?Q?7vsW0u05jSZL0CKcxiiG8JPep7i+46gvkR/xQUYltjfiIMe0x3ZANz36XW?=
 =?iso-8859-1?Q?mJ/TL2fbBGx+2YSOpwAYu4+xrYTt7HZzcD3THv32tpnmF5XC6st6vat8t3?=
 =?iso-8859-1?Q?iKrCtHUsQxmFjuv4dluUVFWX0qXFrwMlXZ7PZe1Y9vEvM46nrm6xNg428B?=
 =?iso-8859-1?Q?0FwZia4UCDGMILMkmq/TqR8o8Z74U4r/13gXJxSfvELLTj3KtLo4fVap0N?=
 =?iso-8859-1?Q?6j8cojVUDZ15fn1xL9U6dbbLBWf0g2VeAwiFe3xBS0n9TZeMGUt2oSbFfx?=
 =?iso-8859-1?Q?x5ECS4hn++86jxBolsyzvGQj9wW1/Z0vdxSXD4kbOX/NdV474yLtkG7Pw6?=
 =?iso-8859-1?Q?qA8QA0unCtpgCoQpt236dZckwIPxpiE3cWglLMswtP10wkg7c7p+2TE6vg?=
 =?iso-8859-1?Q?SJvIzXfKKoAqMsOkvYLPmXO9tg7DuRiKwXVc8ylPhUNR52sKM7+7YUSS9x?=
 =?iso-8859-1?Q?Q22pCMRNinlcuoPqcvgTurMBzMaO2bozS8uDxD7gyjrwv6DXweg93JZ+Va?=
 =?iso-8859-1?Q?Prc5QYqVwjIXlO83ufaYgPPrIwReDdXjj8W/5Cs5cuXd554vLfd0PnCJTX?=
 =?iso-8859-1?Q?42kpc51PdiIMifksP6gYEpakbqiQT8QQr6QJB9bFwcWHiowwk3HF169l/N?=
 =?iso-8859-1?Q?Umpc0yBrQ1wVBjBrcuTzR3aqVg/sQwTO7HO1GBf9/UoCc26EzPlUiuNVfR?=
 =?iso-8859-1?Q?S5uAxv1aR7IFu3mRqY8r+EXOfE7QwKTBlBE3sa85A4r7NGAwppF+RcucXs?=
 =?iso-8859-1?Q?Tk0hyLt/koWYAdITs0pT0TSC0ud91hV+7A/wxjNAMCLvOwHyTReoHxxyqG?=
 =?iso-8859-1?Q?mQNR3KIyBAus34Z7p7B9V0olTdXfr/ytJM6oa+rXC2XfQak=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silk.us
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5639.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9650d3b3-b6e0-46e5-d8ad-08d92f253d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 11:12:03.5235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a3c5477-cb0e-470b-aba6-13bd9debb76b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7gzvupXTEBJHyST0axpZ4b7cyL9hbAgDTWGGgc8xYBz6XHOivDdy0sm5aRhM7pHBvTEgFPIULSv6h+TYqSZYhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2657
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thx Matthew

1) You are probably correct regarding the place the actual crash happened u=
nless something happens in-betweens....
But that what the gdb told us in addition, the RDI shows us the value of 0x=
00000246.=20


Jun 10 20:49:40 c-node04 kernel: [97562.144463] BUG: unable to handle kerne=
l NULL pointer dereference at 0000000000000246
Jun 10 20:49:40 c-node04 kernel: [97562.145450] PGD 2012ee4067 P4D 2012ee40=
67 PUD 20135a0067 PMD 0
Jun 10 20:49:40 c-node04 kernel: [97562.145450] Oops: 0000 [#1] SMP
Jun 10 20:49:40 c-node04 kernel: [97562.145450] CPU: 36 PID: 12668 Comm: ST=
AR4BLKS0_WORK Kdump: loaded Tainted: G        W  OE     4.19.149-KM6 #1
Jun 10 20:49:40 c-node04 kram: rpoll(0x7fe624135b90, 85, 50) returning 0 ti=
mes: 0, 0, 0, 2203, 0 ccount 42
Jun 10 20:49:40 c-node04 kernel: [97562.145450] Hardware name: Microsoft Co=
rporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
Jun 10 20:49:40 c-node04 kernel: [97562.145450] RIP: 0010:do_futex+0xdf/0xa=
90
Jun 10 20:49:40 c-node04 kernel: [97562.145450] Code: 08 4c 8d 6d 08 48 8b =
3a 48 8d 72 e8 49 39 d5 4c 8d 67 e8 0f 84 89 00 00 00 31 c0 44 89 3c 24 41 =
89 df 44 89 f3 41 89 c6 eb 16 <49> 8b 7c
24 18 49 8d 54 24 18 4c 89 e6 4c 39 ea 4c 8d 67 e8 74 58
Jun 10 20:49:40 c-node04 kernel: [97562.145450] RSP: 0018:ffff97f6ea8bbdf0 =
EFLAGS: 00010283
Jun 10 20:49:40 c-node04 kernel: [97562.145450] RAX: 00007f6db1a5d000 RBX: =
0000000000000001 RCX: ffffa5530c5f0140
Jun 10 20:49:40 c-node04 kernel: [97562.145450] RDX: ffff97f6e4287d58 RSI: =
ffff97f6e4287d40 RDI: 0000000000000246
Jun 10 20:49:40 c-node04 kram: rpoll(0x7fe62414a860, 2, 50) returning 0 tim=
es: 0, 0, 0, 2191, 0 ccount 277
Jun 10 20:49:40 c-node04 kernel: [97562.145450] RBP: ffffa5530c5bd580 R08: =
00007f6db1a5d9c0 R09: 0000000000000001


2) In addition, we got a second crash on the same function a few lines abov=
e the previous one=20

Jun 12 11:20:43 c-node06 kernel: [91837.319613]  ? pointer+0x137/0x350
Jun 12 11:20:43 c-node06 kernel: [91837.319613]  printk+0x58/0x6f
Jun 12 11:20:43 c-node06 kernel: [91837.319613]  panic+0xce/0x238
Jun 12 11:20:43 c-node06 kernel: [91837.319613]  ? do_futex+0xa3d/0xa90
Jun 12 11:20:43 c-node06 kernel: [91837.319613]  __stack_chk_fail+0x15/0x20
Jun 12 11:20:43 c-node06 kernel: [91837.319613]  do_futex+0xa3d/0xa90
Jun 12 11:20:43 c-node06 kernel: [91837.319613]  ? plist_add+0xc1/0xf0
Jun 12 11:20:43 c-node06 kernel: [91837.319613]  ? plist_add+0xc1/0xf0
Jun 12 11:20:43 c-node06 kernel: [91837.319613]  ? plist_del+0x5f/0xb0
Jun 12 11:20:43 c-node06 kernel: [91837.319613]  __schedule+0x243/0x830
Jun 12 11:20:43 c-node06 kernel: [91837.319613]  ? schedule+0x28/0x80
Jun 12 11:20:43 c-node06 kernel: [91837.319613]  ? exit_to_usermode_loop+0x=
57/0xe0
Jun 12 11:20:43 c-node06 kernel: [91837.319613]  ? prepare_exit_to_usermode=
+0x70/0x90
Jun 12 11:20:43 c-node06 kernel: [91837.319613]  ? retint_user+0x8/0x8


(gdb) l *do_futex+0xa3d
0xffffffff8113985d is in do_futex (kernel/futex.c:1742).
1737			if (!(flags & FLAGS_SHARED)) {
1738				cond_resched();
1739				goto retry_private;
1740			}
1741=09
1742			put_futex_key(&key2);
1743			put_futex_key(&key1);
1744			cond_resched();
1745			goto retry;
1746		}
(gdb)


Closer to the         double_lock_hb(hb1, hb2) you mention.


Regarding running without proprietary modules, we didn't manage to reproduc=
e, but we are getting half of the  IO load while this problem happens

Thx
David=20



-----Original Message-----
From: Matthew Wilcox <willy@infradead.org>=20
Sent: Sunday, June 13, 2021 11:04 PM
To: David Mozes <david.mozes@silk.us>
Cc: linux-fsdevel@vger.kernel.org; Thomas Gleixner <tglx@linutronix.de>; In=
go Molnar <mingo@redhat.com>; Peter Zijlstra <peterz@infradead.org>; Darren=
 Hart <dvhart@infradead.org>; linux-kernel@vger.kernel.org
Subject: Re: futex/call -to plist_for_each_entry_safe with head=3DNULL

On Sun, Jun 13, 2021 at 12:24:52PM +0000, David Mozes wrote:
> Hi *,
> Under a very high load of io traffic, we got the below=A0 BUG trace.
> We can see that:
> plist_for_each_entry_safe(this, next,=A0&hb1->chain, list) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (match_futex (&this->key=
, &key1))
> =A0
> were called with hb1 =3D NULL at futex_wake_up function.
> And there is no protection on the code regarding such a scenario.
> =A0
> The NULL can=A0 be geting from:
> hb1 =3D hash_futex(&key1);
> =A0
> How can we protect against such a situation?

Can you reproduce it without loading proprietary modules?

Your analysis doesn't quite make sense:

        hb1 =3D hash_futex(&key1);
        hb2 =3D hash_futex(&key2);

retry_private:
        double_lock_hb(hb1, hb2);

If hb1 were NULL, then the oops would come earlier, in double_lock_hb().

> RIP: 0010:do_futex+0xdf/0xa90
> =A0
> 0xffffffff81138eff is in do_futex (kernel/futex.c:1748).
> 1743=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 put_futex_key(&key1);
> 1744=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cond_resched();
> 1745=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto retry;
> 1746=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> 1747=A0=A0=A0=A0=A0=A0
> 1748=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pl=
ist_for_each_entry_safe(this, next, &hb1->chain, list) {
> 1749=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (match_futex (&this->key, =
&key1)) {
> 1750=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 if (this->pi_state || this->rt_waiter) {
> 1751=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D =
-EINVAL;
> 1752=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out=
_unlock;
> (gdb)
> =A0
> =A0
> =A0
> plist_for_each_entry_safe(this, next, &hb1->chain, list) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (match_futex (&this->key=
, &key1)) {
> =A0
> =A0
> =A0
> =A0
> This happened in kernel=A0 4.19.149 running on Azure vm
> =A0
> =A0
> Thx
> David
> Reply=20
> Forward=20
> MO
>=20
