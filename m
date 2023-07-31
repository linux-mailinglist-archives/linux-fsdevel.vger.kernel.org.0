Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152D2769BE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 18:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjGaQJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 12:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjGaQJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:09:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505DD1999;
        Mon, 31 Jul 2023 09:09:41 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTJei029568;
        Mon, 31 Jul 2023 16:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=Y1yTFvC5ghshOn/D+wTNgKJfIEbhG3I57fzT5LoK5HA=;
 b=H7BeegK3fDN377rZGNdiSC24meEaI+dT+IItLnM7bi3NNoVIFjaSD1nK3dvtiYMioyUZ
 2biMXcX5Dpe5cJo6tNNLduanKEo3MDV43EdkMj4PHrSCNR63tQhmo+Ig1cUj2jg0h+Mm
 vChiRj8u+LZPn+bzNdJrYQftfRCJJmSm2q5zPz5IByDz4+B07OwoY649vUXEPxDPcyq5
 2/wgBXpRJW0Ml4mFxLzgRC8MEg3fcDCBqBU/DcIO9zvfntag/5QyFYsGDYz25MicbS3h
 N3e422/wyYWv6nsAET68Cvqt3WZrD/ymiNptwbcEErX3srXHXIr/hqgW7Tzz9YQEoQyh oQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd30dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 16:08:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VEvckv013611;
        Mon, 31 Jul 2023 16:08:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s752kbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 16:08:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwOH481FAldFAxq7K59eCOiUOZNCHg99UYmu/Z64S8FxeQXY1zWye1iG9YxDBmE0wx92W3sK1Zjz9EMhyB/NcG6uIbWYQoPeaKo5Ria8maAiNCnP61ZQ1ZWAtgdCk7zrkGk+Vl695Qr6+hUrHfwF66TQQ8gqzxKitR9sQrUjZGI56lteYBVltq2wv9B05E7XslCQ6xh473dUyQ+eVQpXY3PF/4q25ouABa1O496bsOSWh5tthKZ5QOp8Zz//WNJ9DPtE/OgjEgrCwnWPOoHXG3nzFe5W3RfgqvyDZ+0dlmysFP0IRpreMyY7ZtovIpRTz/RYrFo2Y9KE3rTeXb5bVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1yTFvC5ghshOn/D+wTNgKJfIEbhG3I57fzT5LoK5HA=;
 b=ANJ7UF/ooDIJ4QNzJtfFtRimjPIKSniS/P5NOw8204GUyAJZmlcPVz7kkkJ4Z0UdTGmQx5zF3FQsuB4/a6eQO4p8DTi4FlrYjSHE15xU1R2RkvT/AtQGiFvUEVoeslIycgKfBGh+sVFoBQy9vn2/RKpe9xNq3gMmcaOiCTsK46CNZylQlG80dAclFYobm/RHUVMt9NH6kk4hMPcGHCOjEkgS81xg1mntazucZ3b28WcSLlUq3+O5S9tOQNVrTGpd34zVDanM07eYGAvV5/rlW/2JWvHd4SrzkQlFh/wHO4508y4tnKUbEq6b8P2DQ0SWgNtxO/ULGFZ60c3mRGK+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1yTFvC5ghshOn/D+wTNgKJfIEbhG3I57fzT5LoK5HA=;
 b=g3BgnUY5LOuva5fy3CNQT5IQ5AiJo53uA7DlxVkqpaZ5rHkljKCh+3TDjYcRdJYh0CjSn6za5SYGPfbBNUD5gacehp5PfV9rq17bBPv0m0HBE9gtTo452KtR7Vq7rb45DVoSMdVtpuMNCIpFRtBWBp7DDHmvGRIJLpgicUIKBOs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB7412.namprd10.prod.outlook.com (2603:10b6:610:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 16:08:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 16:08:08 +0000
Date:   Mon, 31 Jul 2023 12:08:04 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/11] maple_tree: Introduce
 ma_nonleaf_data_end{_nocheck}()
Message-ID: <20230731160804.m46rf4uhvrhh6yed@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-2-zhangpeng.00@bytedance.com>
 <20230726145825.2fufoujgc5faiszq@revolver>
 <36f2d5d1-00ff-d8a7-ed40-15eb5d929224@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <36f2d5d1-00ff-d8a7-ed40-15eb5d929224@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0320.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec7a243-afb5-4c46-6955-08db91e053f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iH0bauawETveLxUcIaUoy5GkAIxMJUfSnHNP/hzWjIooF5bqbgQ/CEB8RjlUJCrn05O4a2W1Irl67f6EJcyKjOK+ikb7QZ4uuM+QCeH6cggtyhsR//Vd7ElH6bVeSvE+8lGAPzBj7GApIuFoUFa8wn4dhvNQSW+p/sFRqRpbzoQEV934Z+SG1B2l8uJTy3CUQ/Usw3w0e4lHrxLGBl7vXnU5sT3coCA5loJ8nzk32UEyen82UgXUwOvOTSZHSN6CCCqCF+Xep4YLxO7w6yX26JB4BfJUfelzjSEJcUQS1WYzxehRvEoFL6OVFrBHgRsT6GEbUmq0C9e2x9L+9qzsnomk67jFyjoVY29u0gvcVhGGnF0H1Q5MCqKoGnTbp6PJ/2+H4eJhb7R0/8iUXD/vNEoMuwR6GYo/d13XANdqJLFQUlRgXCAF7gWlG0EIDpSP9jRJgpyt4ZMWjMSucFh6SzlD08T1yxEaIZfhYcwayBYh8LzZMx6lHp68QzNqRHe814OBLaMGHKI2bBiuyQXt2+RyZI7IBZCkj1v6qLExgv+5vH8aSg/ArHvbgf0V4iYU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(5660300002)(8936002)(6506007)(8676002)(1076003)(186003)(7416002)(26005)(83380400001)(316002)(478600001)(66476007)(4326008)(66946007)(6916009)(66556008)(33716001)(6666004)(6486002)(9686003)(6512007)(41300700001)(86362001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3FKb1lUbWNuUC9oVWNZV3EyNWE4Q3RFampZTExKNDE2MEl1dGhtT1hiQTJ5?=
 =?utf-8?B?RTBkWUUzMXRPRTVuSUkvbzhjSFZnTFZRekNSOEEycmZDUW1iUWs0WkdtazZT?=
 =?utf-8?B?WnBaWnpQdkp2Z2EwT2lPU2gwbm5kQmFwZUlwWUo1eEE4L0JOT2xRVGxzZW95?=
 =?utf-8?B?eXFzYTc3dHYyWjIzQ29BbnRJRnBWdmVoTmdOYVB2Z3Jkc085eklpalVWQ2dD?=
 =?utf-8?B?aEtsc3NyZkp5YS9sNTg2TDArTmNqNmNnQWkrTkx1SWxqb3d1Smp1VXNyNU1w?=
 =?utf-8?B?eE1UQ0ZFSU5vc0l5UU9XN3EraVZRcGVuUTcyR0YvUTdQa3Y3b2QwS3hsU0Jx?=
 =?utf-8?B?TzFtRGZ6c1Y5bmNldkN6YlJtMHlrV0FqNFdwbzRFcWk1SXRVTDZvMFNqMDRO?=
 =?utf-8?B?Rm5sZjJjYjhkTWxMeHNZN00reGhhRXdSTkNOUWdpck1adnVUdk4wek1JV3p4?=
 =?utf-8?B?MkV3b2cxUWsybUF5dm5OVzIzV3EvNjdNdXFBRnMzcXkxTW40YmZXa0pqZXFO?=
 =?utf-8?B?RFBXdExTZUdhMGYzb2lUbG5BdjFLQ0tHQU0rYmswaUN6SS9RckJxdUVnRXYv?=
 =?utf-8?B?dUg3bzYzQXcwNEwzOGp3bkFhK1MwTmVzdVdBRGNJSGZoVG93NlB0MjZUZ29D?=
 =?utf-8?B?dWNRbzAwMFZ5NDRkUVk1NUoxZTlRUEdBRDBwbU41T0NZYUdaWVhLVUZ5czh1?=
 =?utf-8?B?Z2pQekdxcm5obDdWMlRFa2JUMWw3R2xRYTI3RU1MTVRxcU4vd01IYnhNMWd3?=
 =?utf-8?B?STc2VjE3STA3K0l0aXFkY2lOZGt2T2VuTnYrZStLN1pSY05rcVVDOEFVMDZE?=
 =?utf-8?B?aDdDQ0pEbUZJWURobzNDQVpQWlJzZURnL2ZrT3FkSEFpSHVLdWtBWm1GNk0x?=
 =?utf-8?B?cVV0Rll1UHlMd215d0pJL3czMWNJdHJTblJaalNuR25RZ2x3TmhvN1RJQktr?=
 =?utf-8?B?b0xXaGZ3R0hiTDF4dFlPeC85TlpnRkYzUmFZczgrNXVyQTlIQVhBOTQzNG4x?=
 =?utf-8?B?ZzAwTDFESnB4SUlyNDJoZGRna05BSXcwdGVKS2Q1cEFpREVjZ3lBcWxlcHIx?=
 =?utf-8?B?SjNYaDd2UG1lSEwyOGRtb08rMGJ2K3h2T05vNi9qaithRC9VaGlvbFpQWmYw?=
 =?utf-8?B?cXZkbW9YQ2J1SnlHNFJLUGpRanF4MzkwSEl4K3d1Zmk1bWc2VTdtLy9OU3dH?=
 =?utf-8?B?amIzakxHK2NLRVNXZFc3bUpJVnovZU5mL3hQdVo4OGx4cGdWTFlQYlZHdUcr?=
 =?utf-8?B?SjMxbGtZKzRUS3dEN09USFYwb3QzaEFyOWMxTjJ2MVQ3dTRhT2I3UUhvMmF0?=
 =?utf-8?B?U3p4bTZ1dFBUY2dYcFFoWDBIYmM5NTEyQkhmN05TMnpZY084Nk1nc1VOckdt?=
 =?utf-8?B?QStQUDdGZXkzZ0NVQnQxazQyTUZndHV2ZTBrZ0ViR0VXeHN3ME1hQlZRa01Y?=
 =?utf-8?B?eERjVTRza2ZHbGNmUXdCdDdCQzlkT3gzR2xZNkRXdzkyb0RDOHNyakhIVVhl?=
 =?utf-8?B?NzBZdzFWVFdpSjFoZnZYdlpucW1ORWpwbVVLcTllODd1RndPV2FmV0R6bWpp?=
 =?utf-8?B?Wkc3UnJrMFlnMmZkZ2g2K2xiRVJNV3o4WnlhRUhEOERIalJob1g0SVNIeUlZ?=
 =?utf-8?B?NisvT0ZkTW50bXowQm9IOFpiWTRISkVQVUswK0RObGZkb3FhNDJxR0M2Yktl?=
 =?utf-8?B?WHNOT2lpK0JEK0lTM2J4WHR3YThCTEZxek8zekVHTnZDU0RsVHZybnl2NzRG?=
 =?utf-8?B?QW9rSGJVS2lseGozelY5UXhOU0sxVlFxOHBteTc5SDgvRWxEaEt0bEtWa2l3?=
 =?utf-8?B?b3pHckZnN1JuUmVPRzZzNDlCWmZaQVRhZHhRT0xsNnQxQldTNXJJNE50L1cw?=
 =?utf-8?B?Q1JsWEpYQ0xZZHNZNENWTUNFUng0OE9PRTVYVVJURDBnS29TcitJV2RDbTRo?=
 =?utf-8?B?RWlBczFETkFIRTQyaXZwQm1neXFwTGNUcnAyUkl6cHB0cGNDLzlxTC9DVFJJ?=
 =?utf-8?B?OXAwT2ttYisxMHBnZ3k2dXQ2eEJhS3lSOU5DTWJhZGlWUDBZRVRnQ2Y2QUlZ?=
 =?utf-8?B?bVdRM1RxZGlrTmtzVUVFUW9sSjdZWDcwUW53am9uWWRHa1MxM2tud0tiNE8z?=
 =?utf-8?B?VDEydzk5c3NERzdpQWYyTUhBQXZzSEd1WHVacGtxMFZWRmNxTHA0cEpmdTNi?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VnAycmd2dWhCbFA2R1AwSWFWSkZNYUVzWlgwTENGdHZ5djcwREV3c3Z0WThT?=
 =?utf-8?B?RVVoeWpndDNsVUo1VU5KcE9USklFcU1tYXBMbWN6TnozMTFwUHpIbXhOaStp?=
 =?utf-8?B?cmNLNEROV3FyVkdrUTV6WTdSQ2JLTy9RNnlna3VsL2R0dUJ6U3ZKMHBZVmtk?=
 =?utf-8?B?WHJ5TWJWYms5T3VPd09ZSk54RWl5K2k1TTE4ZkJJcXRXZFh0UTQ4bTIvZ3I3?=
 =?utf-8?B?SmtyRjBFamUyMzNKaVgxa0Rud2xuM0ZQMGtRaENXcHlRSFlneEZCdGRXbnlu?=
 =?utf-8?B?M0JHSHdxY3M2aDRMRks3YUNxWXJ6TTVsL1dZcGlqY3RXMGpxVnhDZGJyTS9W?=
 =?utf-8?B?Nm9zbC9GR01ibmo3VEs1Yjl6dllzeS9xRm9NeHlicVp3OUd2QzltcVRsV0F4?=
 =?utf-8?B?N2F5NnZBUVNHZ08rdXN0TFpvdllTb3pEdFNPK1RQYjQ0bExIVTNkYW5lZTF2?=
 =?utf-8?B?ZHAyT05QUjcyeEhZQVZXcDlld2ptaGZxaUI0TzFWc2RwVGVlQy9Zb011K0xE?=
 =?utf-8?B?cXExbWxSbmJnckY3VnY1VS9Dbnl4NmhGSGZzYUdtYzNRRXFqSUlEcEpQUXlV?=
 =?utf-8?B?RmQzTXdHMDZJT0lFVGF4V1Y1dEVVY1JUSjdyUHpqclIxMWg4cXBLUTZuOEFE?=
 =?utf-8?B?NG5mQ1VwL3RkWDZuV2JacW1vZ0NLWjlwSDJZZTNBR0NQTVNwWFIyWEwrSHQx?=
 =?utf-8?B?MHAxS3JFaHNzWTYwVDdYaWZOdnYrempsRTMzZ0pCdWhJZ0RJeHFMRUZsWEN4?=
 =?utf-8?B?a2VxRzBxOXhJSEZIOWVza0ppcCtsbE4ydFFqTVQzN3lzcGx6MTNOWkhsU0hT?=
 =?utf-8?B?U3ovY2hrd3lKWUErSzRNTGpPcHFYdktLeEgxaWc5M3ljQnFKVnlLRWNtbzM4?=
 =?utf-8?B?WnVwRzIrS3NCZW45OTEya3paTXc0eUVYU08xQmliaTBoNTUvSWh3QjFEMmw1?=
 =?utf-8?B?djNyZVNCemhnUW5PVk1vZmNXbXdwWExPd24wN3kyRkdvUDBKRW9PRTY0eGpV?=
 =?utf-8?B?QkQ4L2wrL2lQZFN4WUtWT0pEeDh5OUlLUi90amdlY3hKOVdZdFI5RHVOZDZM?=
 =?utf-8?B?SGhkQ29HTTJZNnVCZ0dOUlZLMFAvaVJvYkFacy9TWnA2WnkwRnZ0NkFrSElG?=
 =?utf-8?B?K0F6S1RqOGtycU5yZVQ2cDlyeW5jcEJqaG9VeUZzK3JRWVB2NUVHZFA3UnJC?=
 =?utf-8?B?TlZxeTN1aSt5V3V5Wi9QWk9oc3BZRGwzM0NwU2duRUd4cVBqSDJJUlJhTkFp?=
 =?utf-8?B?RzhaTnE1U3lpbWdtU0ppdGEzODFoeEZMOFZ3QjhNclR6Ym9iTjhrN1ljT3pI?=
 =?utf-8?B?c2hTK1hhOXc1dkNWcFdpWU5oVCtvbXdrWXJCaERHRFVPUW4zQ1NIdUVMZTNX?=
 =?utf-8?B?VnV2WjVVbEc4QVlZZzZzRWpYaVBLQllSNlk4bVB5dmRkeFpjTUVaY3BCUTBh?=
 =?utf-8?Q?NgHAOFBx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec7a243-afb5-4c46-6955-08db91e053f2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 16:08:08.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyZ25Md8CZ9sFsv8kk54ehaQdRtdSS3I54KJluM2riId7u78dpH6cKWFX23uRzl7SZmYA78tnsguTYZp0dVaaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_09,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310146
X-Proofpoint-GUID: 5_BMjRJ1ejXHm2ykt8QV072P-e8D8O3e
X-Proofpoint-ORIG-GUID: 5_BMjRJ1ejXHm2ykt8QV072P-e8D8O3e
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230731 05:53]:
>=20
>=20
> =E5=9C=A8 2023/7/26 22:58, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
> > > Introduce ma_nonleaf_data_end{_nocheck}() to get the data end of
> > > non-leaf nodes without knowing the maximum value of nodes, so that an=
y
> > > ascending can be avoided even if the maximum value of nodes is not kn=
own.
> > >=20
> > > The principle is that we introduce MAPLE_ENODE to mark an ENODE, whic=
h
> > > cannot be used by metadata, so we can distinguish whether it is ENODE=
 or
> > > metadata.
> > >=20
> > > The nocheck version is to avoid lockdep complaining in some scenarios
> > > where no locks are held.
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   lib/maple_tree.c | 70 +++++++++++++++++++++++++++++++++++++++++++++=
+--
> > >   1 file changed, 68 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index a3d602cfd030..98e4fdf6f4b9 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -310,12 +310,19 @@ static inline void mte_set_node_dead(struct map=
le_enode *mn)
> > >   #define MAPLE_ENODE_TYPE_SHIFT		0x03
> > >   /* Bit 2 means a NULL somewhere below */
> > >   #define MAPLE_ENODE_NULL		0x04
> > > +/* Bit 7 means this is an ENODE, instead of metadata */
> > > +#define MAPLE_ENODE			0x80
> >=20
> > We were saving this bit for more node types.  I don't want to use this
> > bit for this reason since you could have done BFS to duplicate the tree
> > using the existing way to find the node end.
> We have reserved 4 bits for the node type. I don't think there will be
> more than 16 node types going forward.

We aren't using this bit for the metadata validation.  We have plans for
the tree to be used elsewhere and I'd like to keep this bit in case we
need it.

>=20
> Even the DFS that has been implemented can use the existing way to get
> the data end.

Please try using it and see the impact on your performance testing.
Think about how often a node is full and how often a parent node is
full, etc, etc.  As I brought up during the review of your testing code,
you actually have not filled the trees during construction.  So there
will not be a walk up more than one, and I'm not even sure you will get
one walk up.

The nodes are also going to be in CPU cache, so even when you do need to
walk up multiple times, it's not going to be a huge performance
consideration.

Furthermore, the maple allocation nodes have metadata stored outside of
the data - there is extra space that we are using in those nodes always.
So for fork, all this is to make walking up to the parent of full leaves
faster - but it's not used for leaves so there is no benefit in that
case.

>I didn't use it because when walking up the tree, we don't
> know the maximum value of the node, and the continuous upward walk will
> introduce more overhead, which is what mas_ascend() does. Doing BFS
> cannot avoid this problem also.
>=20
> The reason I don't do BFS is that it has more overhead than DFS. If you
> think of a tree as a graph, doing DFS will only walk each edge twice.
> What if it is BFS? Since we can't use queues, we can only emulate BFS,
> which additionally does something like mas_next_node() does, which
> introduces more overhead than DFS. Considering only the layer of leaf
> nodes, it needs to walk each edge twice. So the overhead of doing BFS is
> more than DFS.

Okay, thanks.

> >=20
> > Bits are highly valuable and this is the only remaining bit.  I had
> > thought about using this in Feb 2021 to see if there was metadata or
> > not, but figured a way around it (using the max trick) and thus saved
> > this bit for potential expansion of node types.
> I thought of another way to get the maximum value of a node without
> doing any extra upward walk. When doing DFS, we can use a stack to save
> the maximum value of ancestor nodes. The stack size can be set to
> MAPLE_HEIGHT_MAX. In this way, this bit can be reserved, and there is no
> need to do a loop like mas_ascend() in order to get the maximum value.

You want an array of 31 unsigned longs to keep track of the max of this
node?  Please don't do that.

> >=20
> > > +
> > > +static inline bool slot_is_mte(unsigned long slot)
> > > +{
> > > +	return slot & MAPLE_ENODE;
> > > +}
> > >   static inline struct maple_enode *mt_mk_node(const struct maple_nod=
e *node,
> > >   					     enum maple_type type)
> > >   {
> > > -	return (void *)((unsigned long)node |
> > > -			(type << MAPLE_ENODE_TYPE_SHIFT) | MAPLE_ENODE_NULL);
> > > +	return (void *)((unsigned long)node | (type << MAPLE_ENODE_TYPE_SHI=
FT) |
> > > +			MAPLE_ENODE_NULL | MAPLE_ENODE);
> > >   }
> > >   static inline void *mte_mk_root(const struct maple_enode *node)
> > > @@ -1411,6 +1418,65 @@ static inline struct maple_enode *mas_start(st=
ruct ma_state *mas)
> > >   	return NULL;
> > >   }
> > > +/*
> > > + * ma_nonleaf_data_end() - Find the end of the data in a non-leaf no=
de.
> > > + * @mt: The maple tree
> > > + * @node: The maple node
> > > + * @type: The maple node type
> > > + *
> > > + * Uses metadata to find the end of the data when possible without k=
nowing the
> > > + * node maximum.
> > > + *
> > > + * Return: The zero indexed last slot with child.
> > > + */
> > > +static inline unsigned char ma_nonleaf_data_end(struct maple_tree *m=
t,
> > > +						struct maple_node *node,
> > > +						enum maple_type type)
> > > +{
> > > +	void __rcu **slots;
> > > +	unsigned long slot;
> > > +
> > > +	slots =3D ma_slots(node, type);
> > > +	slot =3D (unsigned long)mt_slot(mt, slots, mt_pivots[type]);
> > > +	if (unlikely(slot_is_mte(slot)))
> > > +		return mt_pivots[type];
> > > +
> > > +	return ma_meta_end(node, type);
> > > +}
> > > +
> > > +/*
> > > + * ma_nonleaf_data_end_nocheck() - Find the end of the data in a non=
-leaf node.
> > > + * @node: The maple node
> > > + * @type: The maple node type
> > > + *
> > > + * Uses metadata to find the end of the data when possible without k=
nowing the
> > > + * node maximum. This is the version of ma_nonleaf_data_end() that d=
oes not
> > > + * check for lock held. This particular version is designed to avoid=
 lockdep
> > > + * complaining in some scenarios.
> > > + *
> > > + * Return: The zero indexed last slot with child.
> > > + */
> > > +static inline unsigned char ma_nonleaf_data_end_nocheck(struct maple=
_node *node,
> > > +							enum maple_type type)
> > > +{
> > > +	void __rcu **slots;
> > > +	unsigned long slot;
> > > +
> > > +	slots =3D ma_slots(node, type);
> > > +	slot =3D (unsigned long)rcu_dereference_raw(slots[mt_pivots[type]])=
;
> > > +	if (unlikely(slot_is_mte(slot)))
> > > +		return mt_pivots[type];
> > > +
> > > +	return ma_meta_end(node, type);
> > > +}
> > > +
> > > +/* See ma_nonleaf_data_end() */
> > > +static inline unsigned char mte_nonleaf_data_end(struct maple_tree *=
mt,
> > > +						 struct maple_enode *enode)
> > > +{
> > > +	return ma_nonleaf_data_end(mt, mte_to_node(enode), mte_node_type(en=
ode));
> > > +}
> > > +
> > >   /*
> > >    * ma_data_end() - Find the end of the data in a node.
> > >    * @node: The maple node
> > > --=20
> > > 2.20.1
> > >=20
> > >=20
