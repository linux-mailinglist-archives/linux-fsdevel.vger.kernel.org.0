Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D1B784854
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjHVRVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHVRVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:21:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902992C52C;
        Tue, 22 Aug 2023 10:21:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MFnlP1019394;
        Tue, 22 Aug 2023 17:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Io/pGfqKFrNz/ANVhpr7/ncAFfCKcGuFuYBrKeeC+dU=;
 b=gH8g8PpRIp/ER5+b9c7A6CSlhOIBd7EHlwWhh1VYM0RnEqK0IMDaFvLxj+3FdujqamPg
 WlDeVskZUBsbFdRb0lKiNTdrA7wMbyeF/G2Tm/z2gAHEIa44yzTuX4sxE37wT48tt/Nw
 DWskhvXfboIpp7gUBx+PaYjjkPPhZ3XUMwtWpLtFXOtk5XfawMGTze1tCUEPV9T1R4/B
 vwc6J9tw197YCjgbh8rYqLGnNue7vtmkgx0l+5IQPqv1ikSzUp3goEwjAuc6ycU4U01t
 0bhyE3td/VFCOpHjTA2kq5DdyZmi7Jp6paEghFju3ZlSrK8e3n23RVvH80HUEpv3tm9r gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmb1wx0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 17:20:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37MGR4nM020238;
        Tue, 22 Aug 2023 17:20:53 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm657abq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 17:20:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPpty1YTuWjS50Di1WBCyht/S8GyMYh4lCrNZu0ITEM/34qTPg+Z9uJPIcGYlWzOz5m3jpyAi92eyedJB3SA5NIe/AuAxXNBCQdYP0LITMuqGQBvzmlRk1gE0JLmpZ3XbbkEYQbFUfgii/1kEjWvrhzh5UOh0JFbMD9C4FcGZvdHjNkWmKP8PqghFLjqCa4cmIrd1yj4Sx3ZwFCUVAJTsgXtTB/EBt+Gvv8YWzqMKoX/Utc2dy2iiFKib4yILTJExdV9YlWSSc0Sp4AFcN0av+HEd2aT/1tpfIrY/6ZYQHfciJQIhKCV2Fj6S0pK9slctfp9qlIfauKwnR0L1Ig1MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Io/pGfqKFrNz/ANVhpr7/ncAFfCKcGuFuYBrKeeC+dU=;
 b=LF2lOmBnFq8j6qPMlWIcfop+DBMTbl3vC1Z+yKpbE0BQF21x2o9DvfjIW1XZN557zRC2IpRXZnlm8sWQUER7SY1nndpxpuinaZ3AJNkUI3jNuc6EvDMfyZNZmNp5D/uzBFz5NK+JVqH7UgB+N+waV7OuZ4XXdUB28WLODKByCE3VsPkUcd7ggBryeDHxWihCrXfqA5ZruA2a1sfTdxlVC6xhSXDaesKLRoiJrCj+9vGfpnK+l6e1z93bNJV5CObThdtjOlXRxbxF9ElJQy0eCz5xxeTfJK1R9KKlNQxNNlMdQEykLZbBZyHVkTxP6m8b/y+W33MG+42nK928NKxL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io/pGfqKFrNz/ANVhpr7/ncAFfCKcGuFuYBrKeeC+dU=;
 b=gbKxtAYliIbr7QcUfh4s53oL8RDOllK40vTXYhc9OqXASXm/4S1d2Z9ZgZw+CEEOE+Te1W1m6fVCpxR46YiZzRiRzuuFkFabP3KJjptWJGwE22FhJGRmpV+jwB0i256Jf1ZFFgUkmSLUD8k/xlUBqvLWYKE8x7sYuA43u+gTE8Y=
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11)
 by SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 17:20:50 +0000
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::f981:32d8:3526:993a]) by SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::f981:32d8:3526:993a%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 17:20:50 +0000
From:   Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "# v4 . 16+" <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5.4 0/1] mm: allow a controlled amount of unfairness in
 the page lock
Thread-Topic: [PATCH 5.4 0/1] mm: allow a controlled amount of unfairness in
 the page lock
Thread-Index: AQHZ1H58SmPzPFSBAUqbTsNrSNm3W6/15d0AgACrI4A=
Date:   Tue, 22 Aug 2023 17:20:50 +0000
Message-ID: <D13FD910-FB1B-4DD8-9FFC-1BAF2C1390BF@oracle.com>
References: <20230821222547.483583-1-saeed.mirzamohammadi@oracle.com>
 <2023082248-parting-backed-2ab0@gregkh>
In-Reply-To: <2023082248-parting-backed-2ab0@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7860:EE_|SN4PR10MB5622:EE_
x-ms-office365-filtering-correlation-id: 1b4d4157-a90b-4eb5-8310-08dba33421ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UKrKCmEn+tW334scjFwxL4CNz/03DOFbg+LfpHKO3Yly0mMgocmMeh/PTmn6aY2WiG9pYXddpn79+nQLJSNRNRIJxrfLYnT5mTdF5/3qxv4gnDDtrqCI4cQwfG+lE09GyJvPuaI/ID4qALIfNwXo3/BHKPtmBo0L4ILtHlLlwjLXDlKeG71SDX4S39UgJFvSbYefss4IRGyvR3Vuwb13P9U/kr5L/+eKiJC0WP1IDtS+1JUpFScnPmCrXEzG8L+Ma7WlnPY+7vLvgxKKM5zAnfdsL+foaJkMHbS4r3oUApqKUxl/m6u1cxANch/lpe8FA80XidTEf8l752g7DDtfQSwSdmXHz0xXFmPBg7mMjdOSQxFRV73tLd0A6q4Px6CG2TBP0ejkgMtZX2EqJ0GmaVNpBU65bxMyMEjmVBO/aH/QvmqgfhyWjL8DA6mvXBCENw30ZvxCUWeHRTm4SpdrbvUnAMbgBCMcOzJ4R1WOawL/1nwxjRGOYxySk7/GDaarl9hMtqI1kAt75jQ3vIvkChQJEAZztMQSjzBqDP5zWGmKYJARDv5h8d/Szzfhf6DSeBZEbOfqn9aR289Sm+y2pKlYbdEgIiPi7nrNYf0AyV0t81O8ra7tZr5UiFpv4lyIFQrVXI8/bibDis7ntw/HEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7860.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199024)(186009)(1800799009)(71200400001)(86362001)(33656002)(36756003)(478600001)(8676002)(5660300002)(4326008)(8936002)(122000001)(38070700005)(26005)(44832011)(38100700002)(7416002)(4744005)(2906002)(6512007)(2616005)(91956017)(76116006)(6506007)(316002)(53546011)(66476007)(6486002)(6916009)(41300700001)(66556008)(54906003)(64756008)(66946007)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nWiiZ3ZLFt2mBqStd5gOaskdXtW7OdU+5vV41RVk+R76Oj7aG/5Pcz2heUVO?=
 =?us-ascii?Q?dSgJ5Pz7sl4YmVBOYRHk8E3FXLGQoL3uZhM8EVtVjSOjnp11F99MCeSbId0m?=
 =?us-ascii?Q?XSDNzTH60JvYSA6ZfMKJ4C2eMwGgklrpkOKPW+iebCXOgS4eX6nCRK7ufQt1?=
 =?us-ascii?Q?ALSS/2EVN9YDAoks+79PDQritO1qW4WTyWYxRLW70Js49qR3P4U4bCX9sxgU?=
 =?us-ascii?Q?EePMNPZ/JL5up78FvVpvcMc8BBZubgbIMptYDyX+GDOcECJa/bDpfFk1RLP5?=
 =?us-ascii?Q?UK17/LnNu1FD3W/oRhJ28cuq/5Qe3I+6SZTsKjvBV0vc5svGuZo+lIFEPlCs?=
 =?us-ascii?Q?QJhqbS/K46WASUbE/CnZ16bRjqvzR7JRvoMFyknYTTDLTQE8g+Yr6UnGLYqz?=
 =?us-ascii?Q?V8qB1t8nrEInfiZyTEuBtB6xCpT8kPf9jh/9wABizOcu6pn442vN2OwDVgXl?=
 =?us-ascii?Q?MROFX4sclq6+/mZqC6X5gh4ExXZt9joTl+UTbAgWJYT9JJiKtAl39D2iMQV0?=
 =?us-ascii?Q?UQZaViEgoKrUObp5DSzA1jlCuuSZTvdA9VnGxvX1Md7rFjpNogf9Ic+YCJVA?=
 =?us-ascii?Q?7l1mqdgACznxbGKBKmme6lF+lkZIW7y7Xu0Y5pNUMKO/jpkp60cn3a0bNMv0?=
 =?us-ascii?Q?XXH/RlTTY/ysvpc4smGzcnwywtIwubpJotfSZrUpie4iNfSR6J9Xeie7u2sk?=
 =?us-ascii?Q?gSKJ7XUFceyw8VlHZbTFyatOmNO+n85DcuVxLQm35Q+5W2W1iUPXQTfeXKRo?=
 =?us-ascii?Q?eyqvir/tV5nuUvdV95gbrm3tngIvtRcpF94daieCJVZZOXarQBUHTKQsB8Sa?=
 =?us-ascii?Q?goapOS1LEev3YuKpCVmsdZcNq915bBcZwzNkvCoM4D7SNJzxfqd+04ryno0K?=
 =?us-ascii?Q?3hkQ4Gn9AYWqofaKBJRRkR7Ord7uO9GoFOEL/j5tg/FGna1BMUdPw6yGz0kn?=
 =?us-ascii?Q?od9cEPfi6lUxZmufO9CHfup6RuX2zqAIXSvl/X+UKut6LeXJs4clN7O9FKce?=
 =?us-ascii?Q?vX+Z+5olNxolQ8iIpgHpCOnVf0jj8EnDv4al/U9wgIvYoxLo9emk40uBcSJQ?=
 =?us-ascii?Q?jptYAI8EisHH+xEYCk/qlxIEIfPpyTRBfghiCU7noo5PwSq6m8s7rIxawVj2?=
 =?us-ascii?Q?HBX+tq/4h2QBN7FhlOig5DNIP25uPbpNOAmXbGKmxrTLlq7+s1VYwVihq+YH?=
 =?us-ascii?Q?DtuqDdvbztTNd59fBv5uOB5IhS3U1/faEX5dfL55C6Pidr0vFZfhd7TW/Hhj?=
 =?us-ascii?Q?VzpOPCtXm7VQ4yxo6mwQjJfKbw8eiadjW3basBed1Z76/a0ZMahbFpWk7mdk?=
 =?us-ascii?Q?j2zrOPBfqSPqf/azmBWbvw3ylu5yAjmN/RvkMGWS58xHFh6KDZFDdtmVa6Xo?=
 =?us-ascii?Q?SSPVwjgjuVSk9Cez+7FKjSEuyflNx5Ch4PgRGpzSr5uaYQAtBK4OovbiYlrD?=
 =?us-ascii?Q?d+S2jXa5XwKJCQbrg153ZnaH5sNwK2DeMh8rLgD+j3K5YB38ClOiwlVOBpxn?=
 =?us-ascii?Q?95lIRQvTPLvEEmMD3QJRF/sqh+AghH0xVXvCsiSs0R9yEZcyia2EbCw7cZ+l?=
 =?us-ascii?Q?UfhbP0Z/UBsYJTQhA190wwo78eaJkYHHlHkUYBLdL9gQUnVSuCTMS0xG8Nl3?=
 =?us-ascii?Q?1vazzwPnD/RsejZQUssAKS4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FED587C8890D2F4F93F09BF10329B91B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?K9Kur3QlEK3LqeyggjYl3xcZBaUxq7nTLBR9ZS6TiaWPcSFa6DHgGcSlcsKA?=
 =?us-ascii?Q?9vWs61JK5kQeK+iJ6as4jXgm6y2hOmozme2eD5BGUBHq8njOj43uSOfYASr4?=
 =?us-ascii?Q?ard1zANdoT5oY8qYVCR0vdBESNg43xJ9WAXblqZe2JBg4IFvYHvXZAskvmUc?=
 =?us-ascii?Q?emqAc3dwHv9q0GMTTndDUN9WtSY94lsZtfAMQtEAt0Q949GFZ14C26tY8ZkE?=
 =?us-ascii?Q?MIOYQLAKHAM35n7VdMNcjUoqNbz5BUzys1nQzgyDCIBL98dDs8c2HeKFT8WN?=
 =?us-ascii?Q?2Uz7oyrk4A489GuA6XLK7OCuG1k6c5JYRm8Rf/VfI1I56I6gWb9lhxIGFisd?=
 =?us-ascii?Q?ngjSucCmrc3E1P0YmL29SieVLTvL98Lv+m3XJMaNcbt3cognCbnoM2Fr5+4d?=
 =?us-ascii?Q?EWazhRbJi8bQzcmdh7LMiCd2fx38Lve4H0FOahgDXvMNyqi5rzVoVbk/RGFo?=
 =?us-ascii?Q?fejEx/iViaqcep646g1xYgUuTHLEIgvTSqF259mmuGg3hsCOV9ax35WQNF4D?=
 =?us-ascii?Q?oGntKHfTad9Ataw5Tde9qi4cpokCBQOTVaCzKJ0BLWfRH5x4YEC2tKouvwkN?=
 =?us-ascii?Q?8awuqQMqAVywkdrlJ291CcRmg2izVDjfaokBu+Zr9xAX/PjndZnqhhJD0H6t?=
 =?us-ascii?Q?Ekl3PITtQqggGgCi4qOD5AW/hoh3Jwm4zEIcuJXWVsF9Kd4VtfDpp7TcZ5wh?=
 =?us-ascii?Q?0dcHHCaBwk9wxAjHtZzpFrQe1MTP8blpx/YnXGRuV0Ytqe3DoPaaIhXsmNO1?=
 =?us-ascii?Q?iqVas/q6JiokRn2hzX9ikbT9nCiuMrbAHR+jFrfDCsaSKdzkeD052zIuNegP?=
 =?us-ascii?Q?zOTw5bJ0KGS1Kf9dq9+aZS59GksTG+hTyCCRow3GcwIzm/M+Srl+0fuI8Avo?=
 =?us-ascii?Q?7uRsjfL9ryPGHyzq7rKCpHyXLo/4YaY1FZ7BQ+9ayoJx9wKLkAsUU2qzEwiZ?=
 =?us-ascii?Q?+gygWIymk0ZnSekn911ihUadx5jgfId9aGrFK6FEKz31rq0/HLfgRq40kV38?=
 =?us-ascii?Q?B5VByJj8b/ElQVSHmZtersDRxRq+/x7OY6WbZ1kBt3AKPUERWEo4xCc+9r7u?=
 =?us-ascii?Q?Iaqyeq/p5YIS0oRtTPbudhYm82sSgEZPm5Ygyqmzly3rGNFusQ3rDPG3yGuF?=
 =?us-ascii?Q?TxzOUaUffgYsvNZXYkZzIJFxb5U5NZ0y8A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7860.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4d4157-a90b-4eb5-8310-08dba33421ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 17:20:50.3784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5TIsGMLbZlI5HzpyBAjO+u6GDj7BTmINiAGF/VdVkmp1Q4cuLuq2gMUCnUWWtYnIeOmXTsDy+T/xVPLqvYM5/kjPMCvuLWV4SOpP86k9D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_14,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220137
X-Proofpoint-ORIG-GUID: qVuO6e5qLeUblgnVtnLGNqNqggu1fon_
X-Proofpoint-GUID: qVuO6e5qLeUblgnVtnLGNqNqggu1fon_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 22, 2023, at 12:08 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
> On Mon, Aug 21, 2023 at 03:25:45PM -0700, Saeed Mirzamohammadi wrote:
>> We observed a 35% of regression running phoronix pts/ramspeed and also 1=
6%
>> with unixbench. Regression is caused by the following commit:
>> dd0f194cfeb5 | mm: rewrite wait_on_page_bit_common() logic
>=20
> That is not a valid git id in Linus's or in the linux-stable repo that I
> can see.  Are you sure that it is correct?

Sorry for the incorrect sha. Here are the correct ones:

  kernel_dot_org/linux-stable.git    linux-5.4.y            - c32ab1c1959a
  kernel_dot_org/torvalds_linux.git  master                 - 2a9127fcf229
  kernel_dot_org/linux-stable.git    master                 - 2a9127fcf229
---
  subject          : mm: rewrite wait_on_page_bit_common() logic
  author           : torvalds@linux-foundation.org
  author date      : 2020-07-23 17:16:49

Thanks,
Saeed

>=20
> thanks,
>=20
> greg k-h

