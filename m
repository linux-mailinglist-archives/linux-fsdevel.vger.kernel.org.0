Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DD16F0FFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 03:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbjD1B0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 21:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjD1B0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 21:26:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E86F26A2;
        Thu, 27 Apr 2023 18:26:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RKPE8r019966;
        Fri, 28 Apr 2023 01:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HAjUXV03FOrY7msA/h6KQKsunQFYhVPwkdYV9hKvrFE=;
 b=J19iJA34MK3EjsmKmvr5Jo27P3SxuTcIReqect1IFYOTkmovQSpWqZIc8nEabtnINLkV
 V3f85beMKu+BcJYNwQNyWTOLaqqUmPe99PrWqEsz7BSGHj1PsJG+eTdUkf8MrzL+FZZE
 wys/o6zHATfo2Fvz0IQ6S3qnnLJu2WYF1HDaN47kI1F9fnUQK6Qj25tF8OiGUxIFQYJ7
 OZzXuuIH7rC2SlrFQP0uYB0PkovVgxoOMkIL4qvpytht4wOvTLIbHitTtwjRjBzbFl3f
 6rfjF3O1Lv80HzIljT2YdpjCKr4uP/lJyrqyx+iQd0WwQREFLoq6Ly6vTz6BHpF1J6Cu mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46c4dafb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 01:26:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33RNULFO032545;
        Fri, 28 Apr 2023 01:26:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461ab8k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 01:26:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPh7yxyhm+rhaTFe8TgqJ+XEJLodFS6LpqJc9NaN1RFQHH4Jukd1pve8bAvf8OAjWlTdDOZfkmK36leTrWbYlL3aQ6Pg2CFJ3fpXotofUpwyEFwIkwG7FQtbQzrT9kG5ceSJrsgLrMdBld7jH+aNvfpwAKqgOdsb9k9qEwNmLTUtf1Op33En+HIJjAhNTJr11iFPUdOTcKuYShxz9SXWsPo9uub3EVJjEBBlwS4ILDEdtkXnLljR9XltMgvrEbIYQmbUJb9Za/3328o8cNqEX0zZk2FuU2FKDfhopbuCbj0dEPvYNbta/sCJBzNp665sAZLPTO462ftszFJlRkPyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAjUXV03FOrY7msA/h6KQKsunQFYhVPwkdYV9hKvrFE=;
 b=Q0wlHodFs/MA9DiK66bEMByXqBH9KhMGeR4jTNP2GrEcRjxQ0insZSnaC6f1ZzPFwWnveLHPCVYXjdTWi6l/h3qMsxjPKnwN6Wn0/AyRBWpVBM5Fn80dZEThesjo6gWoKlW8Wc9YDo6eirqCMqd97lAsedv23WpcWIdOWEr1KCy8RsbOZQi7Xzp3GeGjS332+lzzBkWdRfYjOTBk0JvpJ7d205Kt59mDBaG/Tw6QOvXZHRulyHPQzpkcJKYpLDhcmKY3BE0+jY65HCSn0vuFSzirAcGQoca7Vt9HS310z0mnj9phD7mWVEmO7WJdDtcDgGdIGf4wlBp4xGGrSwclOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAjUXV03FOrY7msA/h6KQKsunQFYhVPwkdYV9hKvrFE=;
 b=eusv2AFlhRY6VfJOdMKOb2JkpMy3XFStUCPQIxP5IeNKGczRc5YpyDoiiLBh/UUGxMttjLZlyYVzYLm1OVj0qFMCAmYLNsFFBRj65pEhGJZzA85DtycnTBl1gsxuIT09mmlkrMm92vFO8E6vzrVIfjGdyZhAfXT6OAd7tTkWjHg=
Received: from CO1PR10MB4418.namprd10.prod.outlook.com (2603:10b6:303:94::9)
 by CO1PR10MB4708.namprd10.prod.outlook.com (2603:10b6:303:90::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 01:26:15 +0000
Received: from CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::97b3:818c:4f87:7b29]) by CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::97b3:818c:4f87:7b29%6]) with mapi id 15.20.6319.034; Fri, 28 Apr 2023
 01:26:15 +0000
Message-ID: <e9d9378f-cf3f-6209-1e8e-17cf3c5d0837@oracle.com>
Date:   Thu, 27 Apr 2023 18:26:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230406230127.716716-1-jane.chu@oracle.com>
 <644aeadcba13b_2028294c9@dwillia2-xfh.jf.intel.com.notmuch>
 <a3c1bef3-4226-7c24-905a-d58bd67b89f1@oracle.com>
 <ZEsJxwbIeq3jHDBT@casper.infradead.org>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <ZEsJxwbIeq3jHDBT@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:805:66::45) To CO1PR10MB4418.namprd10.prod.outlook.com
 (2603:10b6:303:94::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4418:EE_|CO1PR10MB4708:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cf892f-191e-4805-45f1-08db47878f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPZHNOhOeMAWRe6vatdIE4qdN6si1fLDesIudT5boHtgChuWorgu+rIkddmdu7mmVi8mMaVvDzZUGb+2D0p0Edp4zlMYW8lUJwozVwFk4jIgAenab6qFPtz1PYrHX5bxNBCCexB+x2Dq1u1L602s5yCUIbOQZmEP0uhJqkDA9OEoRP8Qoy7xXyN2aSAP3k0A3EiTiVpcdnUvzz4rIbCv9cWhyd412wi+ccrLATMFwdao+tSQese3sN1w2fAglLIi/q8P5WdyTvx5zXpFftwWy72pVmcYJZUTafMy0M6yNQJ+kgjviYRXhXTqU/Y5fbRBil7KU4rqczeYqB127J9yFCMfJT2NW5Y6KT5G4n/srSRYgYbaDANuVMqYeqp29RgKQ762MP/k7I7KOT0NKttRgmCJX28SeAWhhe6Ml1G7K57kgW3VuofP2I9KCjDfsqkcj1d+0AWe7o3RYq121dPJLhJ5wNnkKCuJ6cJSKGNJ9YC96aoObNeESWKgcwCe2Y5fB7ypxwf3xqLPt51nMkd4JouXTkPjD/orcJo4b03IK6N21RPqB+9NioCiM/oFDjXV9KxdI9RGFNv61qK2p0gfTykEnES7n9BjqNo5DyaF4AcAuBVMXGup6buQvj8HqjraPtVnGycN9K1Oya7H7tECWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4418.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(86362001)(53546011)(41300700001)(26005)(66899021)(6506007)(6512007)(31696002)(2906002)(5660300002)(8676002)(8936002)(36756003)(44832011)(7416002)(83380400001)(38100700002)(478600001)(6486002)(186003)(6666004)(31686004)(66476007)(66556008)(6916009)(4326008)(316002)(66946007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUl6UUFOeGpLU1VrNEdHYnJiTjhLenR2NFlMU3J0R0FYQVgvUUlYWld1N2ps?=
 =?utf-8?B?RUhObVIzYlZOeWYzbFpkK2lOeU82Z3F1YUE5eGFiRXRDdEdCcFg0MU8rWFJt?=
 =?utf-8?B?UWp4Tm9Lcmh4aW1mUmdTSjIyOTJhcklhU2JXSFJ4ZzRLSWJZVG5qU2phOS9L?=
 =?utf-8?B?R1d6d245K05oT3FZUDl3eDRDZ1FNcDdWSTlneC9iWWc2eSt4RVU3V0g4YSsz?=
 =?utf-8?B?OG5LbFdYTjlEcGtQN3Q0eXIyZFQ0d3NpbG42bjJwK1dreWxlM01LSm9xcHFS?=
 =?utf-8?B?cXpYb2JxMU9IM2ljZU9XZUhId2hGWkFHMFl4UnFFRGtnclZnQUJWVC9TT2Zw?=
 =?utf-8?B?bGQrc3dMR1hNT25oUVpqaHlNTm85Qkt2dTFCemlKZ0RCT2JTalVzM2VnRkpB?=
 =?utf-8?B?d2dxVW8yUkExZXZWUkFpMllhc0w2NlBPbzJ1WCtXeFhuV3BaNitWcjNPNWFJ?=
 =?utf-8?B?QllLcUEyandwOTZIYnhxa3ZVSWdRUzdkRit1SStaL3JmVzM4cnFCK21nc2NO?=
 =?utf-8?B?QXRCYjFBZlkyN0trWitmaDQ1REhmRnNWNm5iTzFjWVdmQ25lODh4cWFkM2ZN?=
 =?utf-8?B?SWUyMGlpY0dNeUJCQlIvOVFIdmdDQlA5cVgwZFYyaDg5cm43N0JicFpOZnFh?=
 =?utf-8?B?b1Bjb2pmbHlGdVp5YW0zMFI4bDI0VllLMFVDVkFvekpxZnNlOEYvUW9hNXFK?=
 =?utf-8?B?SUVJT3ZDTjBvY3VKSEtJMDgvdkl2dVlNZHZRS0t2a2dhZW1yL0FBUTF6Ui8r?=
 =?utf-8?B?UXZRTExLN0I3RXpmMkhIckFKS2YxVUhRUFRSdU5vZExoOHVONHRQZkNGbWFO?=
 =?utf-8?B?RnFsQ1Q1L2RGUmhTdGIxRHZCSUc2ZnZMUk9WZzVybkNEK254UGNwWVloT1dK?=
 =?utf-8?B?cWVLNS81NDl5L3RQazFXbVZwZDczZGRLakRsa1FOYjVRT2VWVndzVDZEd0V2?=
 =?utf-8?B?NFVRay9vTVovUkFoZVZHSnp5a2NwSFVVUGZkRG00c1hVMWw0YlZiYWZ4RDlH?=
 =?utf-8?B?K3pkTXBKVmFmLzZ1NG5wMXc0aFRqdGJmTFpDRzZwazZWVUVmbWIrcDZjMWZM?=
 =?utf-8?B?VmRCdDRYTVZXYWpUTTIrVS93c1IwR2s2amFMU2NMZ05CUEJGeXpDV2RKcUpp?=
 =?utf-8?B?Y1pQNTN5cldjZGx3NklSZnFHMjRUT05JNUxoQW9vcmdLRXhYUVEvWFV6ZGVQ?=
 =?utf-8?B?NFJKS2Z0ODZLa0hNak04aU5uMFdDcThVOXNNbHM4NFFkeER3dTBLVjBwRjFP?=
 =?utf-8?B?SXQ0OWhGa0V1ME95SG1jajNINzZaR0RJc053b2hETXRkeVJMZFhGdHg3UWZO?=
 =?utf-8?B?aGJVb1VxZ29wd1d2M0dqQUMzYmtVYXpZNVFzRDVhaytrNGIvbW1hRWVzbk1E?=
 =?utf-8?B?QXVZV1JnTjliVU14d2xFODJZUE5IeFZ6RW9tWkduZTdXSWg1Z1BnNVJGdm11?=
 =?utf-8?B?dXpDdXNPK0dsd1VlQUloeE9jaHJrSERwd2k5bHBxTjd0VTM0V3RrTVZ1ck5l?=
 =?utf-8?B?WGRGQXd1UnVSOWg2MnRGMU5xbVBGeHBsMTNYelQ2Q1JMbHU2ZDQ4TGVWMHBh?=
 =?utf-8?B?TCsrWktQVjk0S2EvdlVuaUxZc3RHV2tSYmFwK1NlbE0rcTlWT1FQM2xUY21N?=
 =?utf-8?B?VWZqdi9obm1URnlaUWxhT0VyeU5QcmtLdFU1MVhTK3dlK28wbC9XbVE4SFIz?=
 =?utf-8?B?eXMwYUhsMjR6OFpYWnJBVlpPNDVUakEwVHQ1Z2c5VlhYcVFNbW9vOTFuME84?=
 =?utf-8?B?UXVJOVFlVEs2RTJ1ZG8wTmNmQnUrZlIxWk5COWlzQ1RkVWFSdklGQlppZUFW?=
 =?utf-8?B?cVdic3VzZ29IM2pQbWE1ZzROK2o4dVlRdW8vVEE5UW5uNEkxOWg5Z1BFT2JJ?=
 =?utf-8?B?eEc4OTlPNmdpdnIvVk5JemhZeXdKbFlSMTJia1Y5WVk2VlBPN2crRm96Zlhs?=
 =?utf-8?B?WTkxWHFEMmNUSDFKbEZEVHZVUERnSkVpdnlmeFk1MUo1Mjl6VXB5azVFd0F0?=
 =?utf-8?B?bUZOSGJqdS9pbHpwOS9udXp0NHNMV0xNVStvYmtDZFBrRjZFZlgxT3VLSEJR?=
 =?utf-8?B?bDJwcm9iZ2EvMGEvZ2pGWTVQL3NTVzdCcVFSYzhucDFwZHA4dUhBL09sRlJa?=
 =?utf-8?Q?wDnfFMJvC/gVtQiZLbHJcgnb9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Q2g1ZjVsM2V5ZUp6Vm1wenBEL2JreVJGajNIQWVFRHBGNHhvRitEQnlDRjc2?=
 =?utf-8?B?YmtKckFzbHNVV1RPdHUyaHdya0dyUm1teGN2Zlh3TUI1YXVEMU1vdk5pT0U3?=
 =?utf-8?B?N3Rmald6bGpDZWNKdjNJUXF6RUVwY1pZQm5GS3ZsNnBjemZQak9tRkN2dld0?=
 =?utf-8?B?NGs1Q2tQNGpIMWhCSDRESkZTeXZva01aMWUxbmJISHU1SnZJVkFWdkhvRFZK?=
 =?utf-8?B?dWFtVDJBUGp0L09IaFdLdDJRK2VaNG5OWUh3cmMxZjhMV2VnM2ZqQ28vcmIz?=
 =?utf-8?B?V2JUSlUyOTNpVmJTVmdOOWdHcFB0bkdJbkV2bGhzUjJCUG9HZzNVdVRZUEwy?=
 =?utf-8?B?TTlSZEJrbHZTNHp0Rm5vK3krY0plNVhvcHRleEs0TExobjBDQWkxb0hhaldO?=
 =?utf-8?B?Y3Bnekg3QTdSbnBwL21FeEtuRjdUQ3BnYVVyTjFMd3FMVzhqUEVFR01PSXV6?=
 =?utf-8?B?VnhvVzFSYmhKUFQwL2FiSVdXTVM5UmVDNFp4UGo4U01YVzdEcGh5enFXM1dC?=
 =?utf-8?B?dUxpZi85UE5UdnV4ZnJZczhjMU1NZXIwQ21TeUlPRjQ4NmM5L01TT3UwKzA1?=
 =?utf-8?B?cDNOM04wbC9zMXFkb2o1cWl5bjNUOXVqdkVHazI5clRkS2lDekptV20xb0lW?=
 =?utf-8?B?b0RPL2x0cXl0VGJxKy9jOWs2U3krSFZsay93MStYdU9heTR6UXNDOEJaVGZY?=
 =?utf-8?B?MFBjbWhQVmJ6UkQ2MEpMUGFNZkNFN1ZMQUY5M3hCTE9JaDc0ZDBNOVZmbU01?=
 =?utf-8?B?MUlNY1dacm1aWXRhdXlRazRYQWpTbjl4SmtraEJidTZnQ004NTROb0xIR1pE?=
 =?utf-8?B?ZVJDcEQ1Wk9GMnp2TjllNi9FTjZVTkpjK0FGeFNTdWY4ckJKSUh0MEhsUzdQ?=
 =?utf-8?B?WHhXKzNhZnZDc1NoNTNLY1pCMFlCbEdpOGZtc3JWOXQxN0dNb2hTQ1R6c3NY?=
 =?utf-8?B?ZkZqSUlIc2JzSXdzMXVDSXZQdmFoaTdxcUdQMklsMlZxNVExaFljelRYMnpR?=
 =?utf-8?B?K0pMd3gxYTVsRktSa1EzcngwemZUQW5hYmhZenlIeTNCL2prK2Nydm52aXZF?=
 =?utf-8?B?bkMveWNzdFFRL1N0R3pFcVhpVHNaYVhpQXlmQU9hNWhpT2RXQlZrajBoYUtu?=
 =?utf-8?B?QmtGaVdKM1FqRFZReW0rUys5MFp3aEE5cE43cWNlcFI5cGhDc2dTUEdSbzNu?=
 =?utf-8?B?ZUVieGJrcWJpNTQzTmppUFA3bDE3djFkaWZqbnZQTFVqVUYwdU9RSTk5NFl2?=
 =?utf-8?Q?+b99IevJdg1MH/G?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cf892f-191e-4805-45f1-08db47878f31
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4418.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 01:26:15.4162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmwiIct5g84bmigS8NZZ/qBqoYUUb5uCgvm0pQ8aXt173Yk/isPtpc9gJXxhvfrrt3RYQ1HOAx1gQ4L6aFyWuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_01,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304280009
X-Proofpoint-GUID: DSs5TWfjfKlEWcOsc1DIM5X6KVmryN8E
X-Proofpoint-ORIG-GUID: DSs5TWfjfKlEWcOsc1DIM5X6KVmryN8E
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/2023 4:48 PM, Matthew Wilcox wrote:
> On Thu, Apr 27, 2023 at 04:36:58PM -0700, Jane Chu wrote:
>>> This change results in EHWPOISON leaking to usersapce in the case of
>>> read(2), that's not a return code that block I/O applications have ever
>>> had to contend with before. Just as badblocks cause EIO to be returned,
>>> so should poisoned cachelines for pmem.
>>
>> The read(2) man page (https://man.archlinux.org/man/read.2) says
>> "On error, -1 is returned, and errno is set to indicate the error. In this
>> case, it is left unspecified whether the file position (if any) changes."
>>
>> If read(2) users haven't dealt with EHWPOISON before, they may discover that
>> with pmem backed dax file, it's possible.
> 
> I don't think they should.  While syscalls are allowed to return errnos
> other than the ones listed in POSIX, I don't think this is a worthwhile
> difference.  We should be abstracting from the user that this is pmem
> rather than spinning rust or nand.  So we should convert the EHWPOISON
> to EIO as Dan suggests.

Got it, I'll add errno conversion in the respin.

thanks,
-jane
