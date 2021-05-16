Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E84D3820A3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 May 2021 21:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhEPT2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 May 2021 15:28:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55328 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhEPT2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 May 2021 15:28:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14GJQ8K1052773;
        Sun, 16 May 2021 19:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KAT6NGycxYOfiaNAX6x5KFUGdtH/F3Fae/yVXYyNwys=;
 b=ruIhK0fXGfCgGyOU3QFYRNmkFdZp9hYBMqPSSWRxIoK1mF5nctK7oy5H86yzg0B3aELf
 RgS1tLnsdja8sU3VJR5T/6AIOYfE+wy9MNJWCE5AwylTP/3D0HX3Z/Yol+IOkiwr7djS
 E8oYoYY7XZ8/++/5sOPPQaHegMhYvGc/TR2FsAUomzfrUxQGFwcbIbgavpJHFhy885vo
 CKYHN1MG24w2KcbasAtSOHArPBGP5jnN/7B3a2zlrlOLlcd7Tpxg6LWYpIgWb2h3d9jb
 +BB5RgKTSB6JoFUSnfN7Cs4LfXkHxZtnUv/KmWm/1XYsqPOIT/XH62fxGCZqXwPm9B+x AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 38j68m9kfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 May 2021 19:26:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14GJKxsN070951;
        Sun, 16 May 2021 19:26:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3020.oracle.com with ESMTP id 38j643kdj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 May 2021 19:26:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUSiKO6wXrBaz6SUv55d6R0n7DoL46VsQWpWktla7sytyGpAkAdre3cBFPTDus9PAjP+qz+OfRoNN/BE/NgyYXx0Byk8ZwA1ojJnzMLo6Veh+xzQEu/vo1dEWc7rRCbAgDgx7sgMtdeKR1H9SL45wJmlj/ruLZbFPG/pqdQFEHzPUD7cyEP0B/6hjFcYHWec1y6jfvz7bPiZfAy9yUeecqLWqZj+dDyKMzVLm7qh7DgrffuIPv+69k690dpV0++3VsXqJ0sv5EP8ucRhx9TzhoXI/levE72QEe6AvMpcUUytb4TZooXeGj6X5wnMHZWSdHdpPpX/xG1BQEX5PaF+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAT6NGycxYOfiaNAX6x5KFUGdtH/F3Fae/yVXYyNwys=;
 b=giN12Sf49SWDjFr+nI/o7/N2PPAg9Cpwg9UlpVLDaZCYAnFqnOSNgnD4Nu3g0wtKC6L2fuWM4/Pp6hL74vnqiim3D7+gvW6DJdCgTyKpZayKWpEbMJ+Ewfc4ZNwS67DmmKtGzPrfLVu0TkrxtxvcoN32taueXAg+//2h6hJZ7yO4s/OjmSYHlVWypjVdGoHcc5C94rOyCNPTv5xrHxPTUCObi29ZnSkGqhb/vo9/+ISKelfRATX6WR2xKjcvpuAu7jF75Psj82+coV2FU/PDKOq2f5S3IorS6XmLeZ7/94PxUYvFCZAAKQYgVN8FS95rOU6Re2sDBmSXHJ06k+92dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAT6NGycxYOfiaNAX6x5KFUGdtH/F3Fae/yVXYyNwys=;
 b=EPIWY7ZYBuF4W67cRCr/uOMIwbpjwpqukxzTMWenYt7oClmrAR+QyZhEApp6m0Cs9/n7uPx2NxEHIZnaXrskPd47ZViQ3b03aWIA1dubDZBt6YXRntOdev5/+7k8l1ou6NQlDBQjv7B36BA4I0e3GAVOU9iMOtbkQzmG/zQbT4U=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 (2603:10b6:910:42::14) by CY4PR10MB1448.namprd10.prod.outlook.com
 (2603:10b6:903:27::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Sun, 16 May
 2021 19:26:54 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::6988:8f21:a040:d581]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::6988:8f21:a040:d581%7]) with mapi id 15.20.4129.031; Sun, 16 May 2021
 19:26:53 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v10 01/33] mm: Introduce struct folio
Thread-Topic: [PATCH v10 01/33] mm: Introduce struct folio
Thread-Index: AQHXRq9z5MmwRAsVWkK5UfPtNlIVHarkZDYAgACcKYCAAYUcgA==
Date:   Sun, 16 May 2021 19:26:53 +0000
Message-ID: <506810BF-1A80-4BAB-9266-58764E8AFA44@oracle.com>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-2-willy@infradead.org>
 <0FF7A37F-80A8-4B49-909D-6234ADA8A25C@oracle.com>
 <YKArlVbtkJo3l1Rz@casper.infradead.org>
In-Reply-To: <YKArlVbtkJo3l1Rz@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [2601:285:8200:4089:7db0:44e8:d52e:a5b1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5077c75-4589-4dd7-1f39-08d918a08ffc
x-ms-traffictypediagnostic: CY4PR10MB1448:
x-microsoft-antispam-prvs: <CY4PR10MB14487DD5FDA087EB170CE6DF812E9@CY4PR10MB1448.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mo99PWbgmlg1hOA6knbdIqA1hBRInUkWh+bnCbFHxOJnyj0Us+TGK2/zv7wCiv/X/TpNfCQ34IoUdrhLKsn57kjaePIXeIjMCyqILZwD4EQUwlp9TR9sVf/uLIwmQEKs+bxR81yylHVkQjSxnk1YhLHqVtndjIgJs9W8IQcP94vci3erGTVCp9hf89MO1eXTWQhS6fqbnwABDTThSMA1UHBBS/W63fApM9MwlNA3PTyeVlQEBBvG3x6mV0uE/qcX0dqLFALzmDVThZb1duqH5alh7YmdBbfYUG8jel/s7GNrwu+hiJyFn2L5SFI4S88mkdSJ6rKPEQAFR+PvK9pis7TXWpTlmlzk6/55tinxl3by1TfAFjWW/Z8L3y31O69wYR0sOVGRS2i0x8F6CMn8HOlaO5N9iInrtl7mAqJZeOzwiLBUU4regIQ6eFdi5Wt+PIROrzbtlfBpAD91H4V31JjjBeSXG13lmawTZ3unEEWWMfVe1PMQOst/16Fk/L3ZAd4YOp2RKw9EsC7cfZOZ1kU/L55orZAKI69mxW+hbewatH/FQU/BL8Xc9s9JieaF4S/YqAfRQ8E6JkboJJmfrVJ5P3hW87HDSZX50jcF34KAD0xGYVdyoP26/Ol7gAPx5qeHkvi2Ct5cvAn39sZn4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39860400002)(396003)(366004)(86362001)(6512007)(2616005)(122000001)(38100700002)(53546011)(64756008)(186003)(71200400001)(2906002)(6916009)(66476007)(66556008)(66446008)(8676002)(6506007)(66946007)(54906003)(44832011)(76116006)(478600001)(5660300002)(8936002)(4326008)(36756003)(6486002)(33656002)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YGjYBMepRxSKqHrBC7Sk3kBNpXYnW6NuH7/6MYocLHdRRI2SAwm9bgDdD+WE?=
 =?us-ascii?Q?EvwDfRI2EeF5JCyni+vxAtvIkZA5BG8l0rJDPvUprP25Apt9TFWA06v4Ykck?=
 =?us-ascii?Q?ub+in/1fBQ3j5KQjNvIQBtSD3B8PUmAJ4ATWygtvINjzntKhBfJci/08m6lK?=
 =?us-ascii?Q?smovY9CqdIOgSsTE2GvL3TSa6VK3gyhsAr/Zc2sKdWA9PBBgGiLLx+U88jsx?=
 =?us-ascii?Q?CfzcGQU5lBrnaS1s1wXkCOUEPTBXMNxXxCLz9n9YtkPMjX2wJny668S33P+F?=
 =?us-ascii?Q?ZVpZ197eA7VUkJbSzhfWp65LeIT44Ug6pQ97qrZeP6WrOquY5gsltdSkdwHs?=
 =?us-ascii?Q?MsZ7lUIjHHitGZ6EguxyFDiB3vwzMNWrAGFzuVZR+IdMGLrOMP+rh6axNtAc?=
 =?us-ascii?Q?xl6wUS3xWcQC2C9zrL9qTR26KWVPvT2fFh7GbrdQNIZdpY49ZjujaZ9JkZuL?=
 =?us-ascii?Q?Y+1QzprZ+NiGnPF+V6p89miKe8sCTtCOxrpw2wrbd0RVOEI7c67lD4yHn6/F?=
 =?us-ascii?Q?Fwuwu0J1ld2L7aTHTbQmEaHBY95UYPAUIRKJsjHEr5O6qZUECQzKuLfi7Ecy?=
 =?us-ascii?Q?x98VGsn7xaof8ujk88HPpvcWJ/peLs7NidI4zwETjVCHkGZ2/F0ena5VKSyv?=
 =?us-ascii?Q?ALoSxmmCHrr18qD45OyEo1Py//PoO0Y4F6sNURlkk//7xZA/pDRPMwL3Qw0C?=
 =?us-ascii?Q?1i3uD6kzQH5IOBL3M6rhLjPTeU8i71nWbe28WLWtCj0YEx0d3MrCA4/RYzih?=
 =?us-ascii?Q?abheFuE8krtEBllw9g7UzJy3udM241vx9pnaUSV/kyMzW6bXgO+muJUYDee3?=
 =?us-ascii?Q?lzek5AM48blUPPh+Zbh1SWTKdo79E6yRpe3C6+11CzYQQwaBx9iH6NCWepIg?=
 =?us-ascii?Q?UidZpcJerITY++5RL1oMa+mwosPRM4J5Vcq2NWFZBM7RS196O6+l3vG22MnD?=
 =?us-ascii?Q?/W1F8CfifhmvpIcbkdT3YyAWs1ZSetQuKqrEl9fghVOyvOPdGwyjMzG4cLzD?=
 =?us-ascii?Q?h4bswydmfmhBTJYPFmev5mUQcBKwAU6cm4Qc215af+sa+/wUiMogffjSB2aI?=
 =?us-ascii?Q?DxJjPSv9xOhUKdU2PBdMihKXtLnjOiYEHa/4Llt61gz6yNbFthhlyl5pkksF?=
 =?us-ascii?Q?aAu6siPEMFaRgn/xFGCOAelDER/ctZlJzSVYixWieuv8F4Vq6g9XDw/As7F3?=
 =?us-ascii?Q?8QirWw9mi2/eD9yrZpOhvb1Dtb1XknhPm5b7ElTQxDIfoMswsPGKccwgaiKn?=
 =?us-ascii?Q?+TqnXDUcogjUqHlB0yMfa/aHuv3diTSC9BwScYow0OmGgCc7OmU6CB9mURS7?=
 =?us-ascii?Q?kCv1TIX6VtHdn4n2ukeyXLRKV7ZIzkZobYgOaFHjdoUJP6oGYbq0tKBroEP6?=
 =?us-ascii?Q?bRqSWKP4t4ZFniqHE3NStfLGf3B1?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C1C511A6F3A50489E1D2E0C4F08ECF1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5077c75-4589-4dd7-1f39-08d918a08ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2021 19:26:53.7455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +u7VYhDrGIWzuV8OOdgJL7uhnGUNxLfnfaoXrjL5pKNnsW6PxL55L1nm3L7K/lScv/yM4vBeQmrhc8E3nixk7VntDXW2rw9nhYZCZtYGZ7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1448
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9986 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105160148
X-Proofpoint-ORIG-GUID: L1o5PsHVCgWfi2JAdxf2a_IZhdwelieE
X-Proofpoint-GUID: L1o5PsHVCgWfi2JAdxf2a_IZhdwelieE
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9986 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105160148
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 15, 2021, at 2:14 PM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Sat, May 15, 2021 at 10:55:19AM +0000, William Kucharski wrote:
>>> +/**
>>> + * folio_page - Return a page from a folio.
>>> + * @folio: The folio.
>>> + * @n: The page number to return.
>>> + *
>>> + * @n is relative to the start of the folio.  It should be between
>>> + * 0 and folio_nr_pages(@folio) - 1, but this is not checked for.
>>=20
>> Please add a statement noting WHY @n isn't checked since you state it
>> should be. Something like "...but this is not checked for because this i=
s
>> a hot path."
>=20
> Hmm ... how about this:
>=20
> /**
> * folio_page - Return a page from a folio.
> * @folio: The folio.
> * @n: The page number to return.
> *
> * @n is relative to the start of the folio.  This function does not
> * check that the page number lies within @folio; the caller is presumed
> * to have a reference to the page.
> */
> #define folio_page(folio, n)    nth_page(&(folio)->page, n)
>=20
> It occurred to me that it is actually useful (under some circumstances)
> for referring to a page outside the base folio.  For example when
> dealing with bios that have merged consecutive pages together into a
> single bvec (ok, bios don't use folios, but it would be reasonable if
> they did in future).

I like that comment better, or you could just state bounds checking of
the returned page number is left to the caller; that would cover both the
normal case and possible future usage for calculations outside the base
folio.

