Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF747B607F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 07:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjJCFsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 01:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjJCFsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 01:48:10 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F4B4;
        Mon,  2 Oct 2023 22:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696312088; x=1727848088;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xV3JgGcWc596XruBX4DCJDXpfsR1rslcjtMSVmH1Pzw=;
  b=lY7hlvb24Zx5eB/LxKOdMmmjcZ9tkFMcPyJbM0hCOAJA01EvLoFLqVpa
   CyY8+t9a+HaG5Jo2teoi4IsNNNK379gZFA4d3N/xMUy0HUh3BlaamhRwn
   1TGyERBNNLoK2pICzRINQOSWzdB8ZljHxQRE96tUNqWEXUdbjo11o4tHW
   zlOnLZD6srnQx3wHfFtvsaK5DjfBn/nMDzy2ELrpiDl35TlrFtxJIVGqs
   wRpZFnKstKOgzOG1MnCWe2BnxmhnTdI8+ixlyMuKJqjJ3d8GBzv1ppFAe
   czIRunzj0BjwUI2hKp+mYrHCYHvfE7qaozkhMQpF07qNgMU3nPitfPPZr
   g==;
X-CSE-ConnectionGUID: pyETu1C3ShSMziupFxEVMw==
X-CSE-MsgGUID: t0E1tZZHREmlbVoo6hWYzg==
X-IronPort-AV: E=Sophos;i="6.03,196,1694707200"; 
   d="scan'208";a="245855162"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2023 13:48:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIvPFpJGSWWAJ7/LqIh98tUePhLFABs+QCHc90nvNs0B+1NnG9zpM8mGaa441QBwfaY1TIZH5HfWA+uUR1kOAM3ToRELNntvgyB4tt/gyvwfqKlIZI5DG44emvVcDl0N0zXO+jtMOPOkm9Oua+2XIN23ZQ9L3p+leRBOuU2QunAveHWNwBVsJAEXQeY1FkpceufTGYxDdEFdcGXzUGs8L7/OQlxAMeFo/U1Ua308K4kRtd9ogMIyL22ygfZExLTKQFRWMOBZIJeQ23thKDquNLYC7OrpBoBW9vTSZ6n+Yb0Q4XXv/a3wgCEktIUM2S+3WRiVt+fMoUnHJX18s4dHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV3JgGcWc596XruBX4DCJDXpfsR1rslcjtMSVmH1Pzw=;
 b=iiHc+l7BnkZlVwlxJgxfhF4xsq2oqP0Mg5PVraOqVHNQ9ihFWgpDlRgqniIQbBHwvFtHrsYfQNlnEXMyyJzAQxXi0InimHXBif5stwttJm8/TdQn49GbT63d52eUQxesAdjwz4ancVGtzHwrvBnQXxK9yulQtZitYP9OJlZ3XAyqxVpc5xKzbHHB8uOmXf/O33YRsP+LiJetjWkVZ8it+62jFxrgip6CxvEBTb3mpqzs3RM+LAKSef4nDXhe4SRG5Aon7i1z3IQGVoHJVFZF9iPFu6QWH7/P4nmAP4lPWvyhLxiLM3fP3U9Lq9nPjMPhPaa7AaX5ItlkJqOIQDZZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV3JgGcWc596XruBX4DCJDXpfsR1rslcjtMSVmH1Pzw=;
 b=gbuA8LOD94NwM2+gqkopyyOnA2i7F446f9sC/mb2orOrpRoISBcqNPNX6BkeZZu+QzEFNh79xOGDU+OC3MpMNvb35Qd03oEjTtDj0WW+/i/0e38s4oRQ6RMQ68KGih39ynePczHTOkIAGAh2NWB7SCWabQFSnYE0qAUGny00Bts=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH0PR04MB7923.namprd04.prod.outlook.com (2603:10b6:610:f1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.26; Tue, 3 Oct 2023 05:48:04 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 05:48:04 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: RE: [PATCH 07/13] sd: Translate data lifetime information
Thread-Topic: [PATCH 07/13] sd: Translate data lifetime information
Thread-Index: AQHZ6/b2O0pJa8U0g0Ktylc/jkGdmrA2ifHwgABN3oCAAMnuAA==
Date:   Tue, 3 Oct 2023 05:48:04 +0000
Message-ID: <DM6PR04MB657537626F4D0BFB869E82D1FCC4A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-8-bvanassche@acm.org>
 <DM6PR04MB6575B74B6F5526C9860A56F1FCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <1b89c38e-55dc-484a-9bf3-b9d69d960ebe@acm.org>
In-Reply-To: <1b89c38e-55dc-484a-9bf3-b9d69d960ebe@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH0PR04MB7923:EE_
x-ms-office365-filtering-correlation-id: 1cea1c9a-d82d-4aea-1775-08dbc3d4501e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UufP/tGXhMUeaoGPtLeOyZKDEjNCwuoLqFqEbKkzT95qZSDTy/Adso+umSv1r6ooMf9ISHOemfA1XLq9OYrozmOLgKe2jhsa58lhqltwaWnEEoWh8qx67G+ei5V1IRwwgpNcjkPygJDend4KzYhI9rLZHuXXdQlboIgxOgYUmQJAs7FJ54GlxXzMkVa9QNvpmLlnmw3W0+J6/S1L6RGAQF1Ycut+eBrQe+ne0b1bYNMbTVBnC/g3NskrxJrneQ9H9J+7rhpUpEAMFROPNX6Ev3ssilKiV60kC4YdSL/viNU4HN5cN4qRSwoZxxkSkMzB7kI8uLI+7p5wAcrfypCtaSMJHE2VAaHx2QFoeYX5DjlyZo+fpAC6POaza1zsgVJz/K/s6I+a0UcT4ACLLCwvawIjYxWw4uthEn85jEcRHLUxIvXWpy1GlJ+51S4rnIGfpRlU7QiMoIS+nq1VL2YozPWHsVIHvBzeyItHH9IpBqn5q3omHFdDB8tZxi2nda5YsnnVFWuCinjcZMlI/AIW6Il/VDA1HXEq2dFclFSF+T2Gl6D+l2hY7fZOjFGTIgYGK0a5DNpVsH2Yj/rH7WUIeRLjeEbR2zTezz0QuosV6kh9W2Udk/3lI3EN5c6GCEOj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(55016003)(2906002)(4744005)(52536014)(5660300002)(4326008)(8936002)(26005)(316002)(41300700001)(8676002)(76116006)(64756008)(66556008)(66946007)(66476007)(9686003)(66446008)(54906003)(110136005)(7696005)(71200400001)(83380400001)(478600001)(53546011)(6506007)(33656002)(122000001)(38070700005)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2NFWUN5VXN4ZDlETmorcEhNOWszbnpOZUlTdmdENDdqWUJENEZXZlJCdWVW?=
 =?utf-8?B?TzlQbWJRayt0Qnhnb0tSbUFRZTJMekp3VnVtQXdKZ2FVVzJWWlRaVXhFYkd1?=
 =?utf-8?B?T3JHQUZRbkErUHJzR2JqUDhuQzZvNmM1MVZkalR5MVFvYU5kMGQ5WHhGVUFF?=
 =?utf-8?B?RGZtdkJJeE9HaW1ZM0ZPaVhoWGltRjEzbDVJb0RMVWd3cE92NTZmcS9TZ3dq?=
 =?utf-8?B?SG15Uy90MWdaRXlTTVFRaEx0VjFQR1cyRVJGWjZMYUZmOEZrUnZtOWtOb3JO?=
 =?utf-8?B?aytxYmRJdndza2NvcEJlRVArV1gvb0YxMnJmVEVJaUpFdjdGaHg1MmJFTjdy?=
 =?utf-8?B?Ync0WHVGZENpTTVmd2IwSWh0Y1BNSmNFQi90R2o0RXZlamN4L1ltbENNWFdF?=
 =?utf-8?B?S1J2SXV5eDRJbTdET29aNGdHeUFPTkUwRjgxTEFlNURScU90YzRnTkxraHZ0?=
 =?utf-8?B?OWlNVUZqcytqQTNRdFB5SkNpZStwNjBNMTlaU2toc3Q1V3RpSkE0NktRemth?=
 =?utf-8?B?RFFUN2crNG5XWERKM1FWZUd4SEpja2lPYU5MdUdPM2I3MEpOS0lDb0R6Mmdz?=
 =?utf-8?B?YW80VGtzUnlaVjdTdHcxWWJjMnRmS2l4RFJMUGZLcUN5aDBqS3E4dk1aZ1Fl?=
 =?utf-8?B?YnJ1b1BWUW1xZFM0VWlkV01WUlp1OHdnOWtYS1d2RTBQUVQ3NzlrSnRLaUNX?=
 =?utf-8?B?TWVIaUtHeCtrOXcweFBkc3Bmc3Z0RytYaFVDN2treEJEOS9pRlRRVFg3Ny9V?=
 =?utf-8?B?U1prRlEzUkYyK2grVE85bDhEWVNZOGE0SlNzOXJTM1RNTXRZTlUzUHBSZnNF?=
 =?utf-8?B?eGcvTHJ2NDcrbE5qdnRqblFwTW15b3VQQmVtYW5HRE8xTGZ5c3p6TVRkcFRB?=
 =?utf-8?B?R3VzTlNaN28wbVdUY1hKcTdqMzdsbmZFNExML1hjU2x6OFZCVFVCZ1Bqc0tT?=
 =?utf-8?B?L2ltVTQ5cEdSTG95TGFJRTZHcElBcVExbzBCbFJ4ekxDWnh2dkFjYzFTQ2dh?=
 =?utf-8?B?d3hkbzJvQm5VdGRBclZpMDBoTk9GUXVjaEtwT1pUZXZQb0RHM2RVa2d6TE5D?=
 =?utf-8?B?bzNudndkZ1JxbURzeWRlbTdHQ1FKRlg2djBaUk5GK3djZ2h3aVU4ZENwZzl2?=
 =?utf-8?B?Q3d5UkNudmo4dGRTbFpURDZoS0ZFNHBxblJyK0hweTJNQTJ4cW15TGNaSTUz?=
 =?utf-8?B?Sm5EV09kWUN5YWozNzFrZXdPK2N1R2FsVVNIZlN6dmRpRWVBRVVvcUtSNlBn?=
 =?utf-8?B?KzR2U1pVZFRySHBsaFlxMFR4cy9rZ1R0aU13Rm04V2ZEMEpydnhlbGtaQVl3?=
 =?utf-8?B?QnYwR2RxWW55RmZ0bHpYMzAzT2k1QTNXcjFNQmpnQzVsSVk4UEUzTmJmanps?=
 =?utf-8?B?aEpsQzFnRlAvTHY3Vys4dFFSeHptbDF1c0pZRjkzbUcyR0o2aGo5Mk5iLzJN?=
 =?utf-8?B?WXJnQUp4NWc3OWZTSnlTdHpIVk13VUcxb0VhanlER3dtZTUzbEdoQU15QlE0?=
 =?utf-8?B?QVM0M1B4SHpvc3RCR0tLSXR3aHpqOWZDWjk1blZXNzV3MUdVYktvRlk5c3Av?=
 =?utf-8?B?ZVc3bGlXNE96MkcrOTM0bElHSnVpSFFLdjNQeFcrcDJpOFlkbmsyV1lIQ3Q1?=
 =?utf-8?B?bml1Zms5ZlNYY001K2Erc0FGWkIreTdxbVRkc1VFOGtMTlJ4OE0rbXpOMmd4?=
 =?utf-8?B?WVIzVnBrelh1Rzg1Zkg4UEZmcklsUjJyeFd5NUc5U0UwU093MnNoY2pNOWhi?=
 =?utf-8?B?NWVHb3dYWVBZMFVlU01naUk4T2NNa3IwUXVZVXJPMVQzTEZOK0R4ekR6YzZM?=
 =?utf-8?B?Sk95OHRWd0lqd0oreExoQ29qYmwwa2tsZzRlaThOVmlKKzM4V2RJTkkvRU1I?=
 =?utf-8?B?bjEyYVNaT2RxSThBY2ExQ2pYaG9mR0lKYnUzWjJwMmdiYUVsaFVLQnZLTmll?=
 =?utf-8?B?RDdObGhOUGZjemg0ODdCcXBka1JiS1oremRMcVY0NXpPRGhZMStiL3JHOUti?=
 =?utf-8?B?REJpR0dVckw0WlppT0NLVVppYy8yV3RIS0V0SktZZjFtYjNRaU9GdSt4TWdh?=
 =?utf-8?B?NE03QXNmN09meTlUbDlqWlB5TEhtWGxNTzVubFh1blZnUWdBNno5Zy9VSy9p?=
 =?utf-8?Q?S/I7t0eqcUwcLFw3KYDSs6Sbk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a2F5OTN2RjJneHVCK2oyeGJKZDZEUE1zZWhIMDI4ZHZ1dUkzTk1FT1ZvZHMz?=
 =?utf-8?B?SEVCUXR3amNxckwxSk5sSkc1bk5zcHB4bkp6b0t3cWRJRXVGZWNUWmN2VEwr?=
 =?utf-8?B?YUlhbnkrRVpQMGQybWhlUldIQVpJK3ZBeVVRNERyYzlXQWhnamxXamhLZlk3?=
 =?utf-8?B?amxldXgwblA5QmZBT3QzVjhhVUNhWWFxdWtTK3lDQ0Y2VkFRQkNxTFFpamdh?=
 =?utf-8?B?cVZaSzdacDRwRjRYa3pqMzBBQWszUGtjSi9DZGNld0hvb2dqWUl5cWtIMExH?=
 =?utf-8?B?a2ZraEI5U0xMb1BsQmd6a0FydEhYbGMybjRRaHZTeDNhSjhMSzFLcklwaHJL?=
 =?utf-8?B?SmhCbFZoK202S2VWZVBvcTZhdWYxT3hnOTVTVFhNMUIxS3J4bEFBOFNJbGtB?=
 =?utf-8?B?Sk1tbUZVMnBBMzR2bThnYUpZa3BRUDBpa25xYUZMbHBmaGx5Yit0STNoMlNU?=
 =?utf-8?B?YnMvS21jY1JsVE1hRXhnRUF5RGV5bVRnRmZ3M1ZRZUFmZ0lBK21nQWRqY0xj?=
 =?utf-8?B?ZG5Vd0Y2RElLV0thNWNLS1RnR3dpWTU3VEsxUUZNVUtZR0ZUZDZpdUNNMWJI?=
 =?utf-8?B?UXVkUVRXZEF1WHpkVmt0UFpwOU4wSkpheExiSFBUOTV0cGVoSWdKN1M1Ymhw?=
 =?utf-8?B?eTgzNC9iWFNBWE9RZFlOdUhzNU1OckVZdG1EUS9jWHRQZnJxKzdpWnNJS1R2?=
 =?utf-8?B?U20zRjY1NkI3ckU0aWpkNXhrYURFV2JMMzRacmNZOTMyM3JPMFE2OHVTRnRu?=
 =?utf-8?B?VXozYkRQTnU3d1FZT2pEL2E5dVp4SHBOWE84MkNJakFXQi9uVmJyTEQ3eDh2?=
 =?utf-8?B?UEttNzNLVXpENkRxWVpRWkZZcDU1eVVTVTkyY0xNRjRuNEVLTzA1NkVZWndW?=
 =?utf-8?B?M3dWdDBsS3NkRHA4OU1GaFcvYU1OblVBT0UzOERHcHR3MlpTMS93bndCWmtl?=
 =?utf-8?B?UEptL252b3N5cWYrelJBdDYrMDJscDZWWmxPZXRQTE44R0ZqaStXd0R1TytY?=
 =?utf-8?B?MERpSytzb0FnZGxLQ2hLQk10LzRXYnAwWUpXa2wyYU9MWjR6Ykk5TUE5Y2p0?=
 =?utf-8?B?RWkrOVp6RmZMVXBUU3huMThHTGNHemlXV21INmFBbktKS3hVVUNHRmp3a2po?=
 =?utf-8?B?Y3E4QUFUZlFWTUd3VTRKZFRVQi9uUjRQbjVreUd5OVBJLysvdXcvSTd1YnF0?=
 =?utf-8?B?Y2tEWmErMDUwcXhSaUVEMFlLazYvNlZhd2RIbitJYTFvRXZ5VUE2U0o1T00x?=
 =?utf-8?Q?rrRu7CZKpldPqDY?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cea1c9a-d82d-4aea-1775-08dbc3d4501e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 05:48:04.7215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSDMbeOnfMt73GsdyEoVin7yqRng81aWVmMWmyvaD4bXfltSkFfCrJDjnah8rIM2aEGruBoTys1dGDsj3XYJug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7923
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBPbiAxMC8yLzIzIDA2OjExLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPj4gc2Rfc2V0dXBfcmVh
ZF93cml0ZV9jbW5kKHN0cnVjdCBzY3NpX2NtbmQgKmNtZCkNCj4gPj4gICAgICAgICAgICAgICAg
ICByZXQgPSBzZF9zZXR1cF9ydzE2X2NtbmQoY21kLCB3cml0ZSwgbGJhLCBucl9ibG9ja3MsDQo+
ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByb3RlY3QgfCBm
dWEsIGRsZCk7DQo+ID4+ICAgICAgICAgIH0gZWxzZSBpZiAoKG5yX2Jsb2NrcyA+IDB4ZmYpIHx8
IChsYmEgPiAweDFmZmZmZikgfHwNCj4gPj4gLSAgICAgICAgICAgICAgICAgIHNkcC0+dXNlXzEw
X2Zvcl9ydyB8fCBwcm90ZWN0KSB7DQo+ID4+ICsgICAgICAgICAgICAgICAgICBzZHAtPnVzZV8x
MF9mb3JfcncgfHwgcHJvdGVjdCB8fA0KPiA+PiArICAgICAgICAgICAgICAgICAgcnEtPndyaXRl
X2hpbnQgIT0gV1JJVEVfTElGRV9OT1RfU0VUKSB7DQo+ID4NCj4gPiBJcyB0aGlzIGEgdHlwbz8N
Cj4gDQo+IEkgZG9uJ3Qgc2VlIGEgdHlwbz8gQW0gSSBwZXJoYXBzIG92ZXJsb29raW5nIHNvbWV0
aGluZz8NCkZvcmNpbmcgUkVBRCg2KSBpbnRvIFJFQUQoMTApIGJlY2F1c2UgdGhhdCByZXEgY2Fy
cmllcyBhIHdyaXRlLWhpbnQsDQpEZXNlcnZlcyBhbiBleHRyYSBsaW5lIGluIHRoZSBjb21taXQg
bG9nIElNTy4NCg0KVGhhbmtzLA0KQXZyaQ0K
