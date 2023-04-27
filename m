Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757316F0F28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 01:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344391AbjD0XjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 19:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344283AbjD0Xi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:38:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1592DE5;
        Thu, 27 Apr 2023 16:38:52 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RKPLMD017665;
        Thu, 27 Apr 2023 23:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RDISawfO7WSnH3Du0d6x3trJVP9bB3oTOLhC16r+InQ=;
 b=teOKgJAsaILh2xE4ilhrzZWTvDECSq2GtYdtEQ7cjMclnQDETcATUnIDRlbVnYN71CmK
 rvk7FV6yKeZ+UA/1Glk1ZAwbjclmKZ1rl81NZuVEPPwr8zciWBOgtFt3k7U0AJwUiRKH
 L+LoFVyzWhwo+aWf4GpiwZ5wnUv7h73H85gTkNEKFW418sXwj0cMEAud4LPYSLkht1ix
 csZXyIjrdrizIz2sKFwPv0gC+3g8eDvo7v3xmuDv/uwfXaxNH1qYbavZlK3zYC9/Ni9j
 Iqi126jBeHW1oaZIcDfs9N/r+daen0IiuSh5x2J19r/9uTQ9WxeOnQr15QOWT0luafka /Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbw7gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 23:38:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33RNBMb5008769;
        Thu, 27 Apr 2023 23:38:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461a8hbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 23:38:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEBV3gmyIXaUrxuHRgdZtpnux+hnNg/R5Ocbqt976ICnQk5+LbUs3IV5sOzoaJwDXpBvVBnLpoSBkFF0757c/0D12Vk+Vyo+ZMAYlI1GWREtxlW3yl3nJEbY8XCv2BawWGq9Eeqk6V6FjDpsrY6EkZJA2Vaf+ccwuiL9WgiVzuI+F/hDRBiQqAQZwf1O4k6456SIJ806uKEfSjIzpvaquFns3D80+Hbu1zZ5uLcRo0xcmqHu0+OmNIvydr9vBKEPcblzuG+1z0z2j52xbb+SCadbBu5KsPENI3JtpO9jlogIRe3w7XCXIApzEBAuFJajAoX0xYhLZALvAy1TRQitZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDISawfO7WSnH3Du0d6x3trJVP9bB3oTOLhC16r+InQ=;
 b=JfoSPMrnQmdJhoCEpo0dPoH39DdKcQ7oiwHHQmrmLozFPz7fc8EBYaEqTdfjbYErvI390zfCP0V5kvHnsBH228BVYbwfCRfYNBpvH9c4ucDddSNetV7J38tH/+ETyv5kfzGTta7qqFCbNv/lfXXV1TSIWvAs+WHtOs6R7zLdUiouL/fNWOdwIKDutPVlRVMn/ROgIjkv/EeqnQ+9nJrQE7jddu0rQ2fJvPXRukue85dwSvQL5vLcJOLCtnAT4WCdLax/fHeU7ipQxS210c/mL6V+CmIgtGS01stLVhjxHBXq3MhrOVElm+NljRZLA6Dm6EQDnTl6NDlByBz65hlOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDISawfO7WSnH3Du0d6x3trJVP9bB3oTOLhC16r+InQ=;
 b=vBctrNPslMl+nAxFkOsL9Mn0/rVaaMAwb1RKHq5t2aiFl2ReOIZdFqCYvndA8x3wIBBg4WHKI0M1GgMoOlq/c4bcxbu1FD4qtEQsFkrt4GTdG6gZva6wnW1+1Qm7hR+jKv81EUgNUxYXy2fRrIDZOrXzndAv2NDlkbEiG2lE9s8=
Received: from CO1PR10MB4418.namprd10.prod.outlook.com (2603:10b6:303:94::9)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Thu, 27 Apr
 2023 23:38:28 +0000
Received: from CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::97b3:818c:4f87:7b29]) by CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::97b3:818c:4f87:7b29%6]) with mapi id 15.20.6319.034; Thu, 27 Apr 2023
 23:38:28 +0000
Message-ID: <91bbf769-ddf7-4c78-b416-df76d9abc279@oracle.com>
Date:   Thu, 27 Apr 2023 16:38:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v2] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
To:     Dan Williams <dan.j.williams@intel.com>, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230406230127.716716-1-jane.chu@oracle.com>
 <644aeadcba13b_2028294c9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
In-Reply-To: <644aeadcba13b_2028294c9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:806:121::7) To CO1PR10MB4418.namprd10.prod.outlook.com
 (2603:10b6:303:94::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4418:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: d51ed77a-261f-4142-5293-08db47788080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E96rQgzGJ7zZ6/yNVkeHbEF9MMJ/EvziNWQiu2/PeXZpwYWjll8TNWCBYqiwsKSKr9PMvj8BFxb2SjHEQhLwcZgySStYBnwpUJruxa4THbRQen0+5xNH8MRI/CB8i378HD9qEiqjf8Ihq/sIoGs42SQQYqvTziiqd8smyfJLTMubE1JGDDnRc5FjGHgV9SMYey3ru/sj24Q11BWZpyb6cfqnC3+hzMFh8x+/rcWQC3uASEcXY5GbVlkGZpNttgiRkIo+NOKBNaD/ob05sN5bx5EZtGZgIdk2DdcFS2POhFYohHCHGbEPITRZYviw0KADbG/2jkTdTyhdsfSK/T+J1keNqNSQ80w2UjzhkVAjBta3aMFs2eq4/oRwFhfnqRGaGgUhefTbj8p9bhCfZYIAqWCEbpa0lJEDd4fkGNPquseIRIvIGyLcGjjJYEtEhoKUdMvp4XWDQc0ih8CR3UcYrm74326wqAtZZYK4u2Z/Out5vbjl3CalGGkIk23J8Ezl/T8uEXwLjG1NibyygDZ6mT6xhJoCbUVdahEv7gTiyk4+S4hRj0NALFT/wyxfOMzTE0agNiPKP40ccln6PvyPzIbTwF9Upr74pFd1DseplS5PfpIPzl91dJP8BTBNgZ/zHWtzHuhhqdErEdaAK7S+Kf75xhaazJeXXxIXbROAMyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4418.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(478600001)(6666004)(83380400001)(36756003)(53546011)(186003)(6506007)(2616005)(26005)(6512007)(38100700002)(31696002)(921005)(86362001)(6486002)(41300700001)(316002)(66476007)(66946007)(31686004)(2906002)(7416002)(44832011)(66556008)(8936002)(66899021)(5660300002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnQ4QmhBejdMRldqc2E5NlNpb3RZKzU4aHdXTUY0a1pyU2RTKzNkNDA2YzFW?=
 =?utf-8?B?WUJPRGczU1BsRDF5MTR5ekI1UXcrem1YM29WTEpvajdrUkJXMnFHdmpJTDky?=
 =?utf-8?B?cENnNHphUE5xa2RWOVdETklMampGUG1nL3VvMXE5cE5FdVA1K2JkZGJtUmN4?=
 =?utf-8?B?d010QWdnejg4eG5TL1JkV0l0Sm5qUFRKNW4vNU5jVnZNN2ZjWTg3d0lkRU5C?=
 =?utf-8?B?aHRhOG9jTEtPbWMwOGNtaUtJZ0Z0YkdualdQZzZSUTVqSHNudmMwbjdGa25p?=
 =?utf-8?B?eTJSeTNiNTJtd0pPcWU1aVErb05vRzdveG0zT1dKbCtzM3YvMHdmc1dlY2h1?=
 =?utf-8?B?ekd0RE5nazFQdW93MEFjL2o2WVo0UjhUU2xHYkZFSmx5bEtZTUdCK0xvbkVn?=
 =?utf-8?B?V3NnSXEyRVBRRXlTYmFVNVE1cXJzdTBkdUI1dUdpTDl3TWZDbS9hNktNdk1p?=
 =?utf-8?B?MGpiOFEzSVNWS2ZCRVpKTmFYZkdrME10TmYvN2p5Z3BYcURtcFRObmE0dStn?=
 =?utf-8?B?dTVyQVRUcDhvTFlkNEZHNitIbG80eGRLU25KZlRvdUNQNzE5VGVHMTI5WG81?=
 =?utf-8?B?d0NuVTJGZDBNNlFHTmY3UEFTSnJKb0IvZG1HS1Fwc1NJNU0rTklFTURqQzM4?=
 =?utf-8?B?M0xud2pDYjE0UHBmZndMRXQxVUZZRkp1bkFmdE9kSkEzV2Q5Ly9FS3NvUHVI?=
 =?utf-8?B?TnJmMEluVEJ3RGU1enU2UUQrelI3eWZWalJvcG96eDM0N1VsWUovUzJNNnBG?=
 =?utf-8?B?STlEUi80NzgzdUYwRnVhSklTMGFZeHZRZVpvVUlXUytNa0E3QzFoaHZna2Fk?=
 =?utf-8?B?L0J0RE1CTndkbTNnbEt0SUY0Y2VRdmJFYlBnSTUwUmF5T0ZRTS92V0xBenJR?=
 =?utf-8?B?Rk1zeDM3ZUJEUjFSNHJ4aDJtZEdVcGk3blJMSEtnMGVGODJXYURZM3dxQzNV?=
 =?utf-8?B?N3ZIaFZSS0cxVEU4V0lQRjBmQk5Bc0dDdHVQaGVLMnZlaFN4SWlOTEo1alJE?=
 =?utf-8?B?aTIyZmdhK3lWb2pGMmhJN3FRM3d6VVhJUlU3TU1SQThqTkxsWGE1ZDErdDZI?=
 =?utf-8?B?a2kya2VUVEluQXpxUitoaWFBZEtiQjhlYnRxOEVrd1U2RjRad2lLMW1HeVVN?=
 =?utf-8?B?T09WZjZGaHRJSnBOdmlYMW5zeXVldXRLZ1dOcXBVeDhXbFZNU25iY0ZSMlpC?=
 =?utf-8?B?SjlwbHF1MFBocnFJeE9IdTNyRTRnenh4OGlJN3F4cnUzVVprRUhoRTRVT00r?=
 =?utf-8?B?VVZXWFVIc1A2TXppVFQ3MUN4Um14N3RScVd5ODRvTWUwQkRlc3FzZHJhZXZW?=
 =?utf-8?B?NzVSKzB1QWllRS8wZHFlV1plNWdRRklFRG93OFlOV0tQak5FS0Q2QnAzMFZB?=
 =?utf-8?B?WnhqYlE5VXB6dldnU3hiTnV2ZDV0WjA5ZVFBbWpNU01NUEMxa084TEVXK1dw?=
 =?utf-8?B?SGNJZVc0ZCtGeGs0S2RMendiejRyVERsY0lFaXh6NEFadU91ZzloZFd1anJw?=
 =?utf-8?B?Z1hET0QreUhlRGY4b1hCSEd1MzNlczdVNytNcG5VaUg5cnNoT3J5ZVluTkNo?=
 =?utf-8?B?R1dqUnI5ZjlTemk5czJGYTN0Z1U1WmFEUitRSUNMOHVBRUxob2QxTWM1cDhO?=
 =?utf-8?B?Nm96cmZHcXVtVUlGRkF4RDhFem9mKzV0M0xxL1p3SU56cGc0YmIrckl5cWkx?=
 =?utf-8?B?a2RxY0M2VVFLaDNFSVR2N3dBRWI0dXd0M2Z3T29uREZoVkJyL0lmWUJyMmRr?=
 =?utf-8?B?cFZES3g5eDQ1bnBBbkNtWTdNNWphMWVaaGkreTEwZkhRd29JcUdGSkZGZlJI?=
 =?utf-8?B?MXhrN0U4MEdFY1Q2NmFXTVQ4cVNoVFY2Nk1yTUUyVTd2R08wMzV3UTEyOGs5?=
 =?utf-8?B?TXEraTV2anhGei9MbHdvdm9mdjBTaFJXWmhDdlNWRitvYjBVMkZtOXM3TG00?=
 =?utf-8?B?Sjk0QTgzbEJVcEtiVitOM01wOFQ0NldCcno5VkRHWndyWWFrVkNOMk9pOEd6?=
 =?utf-8?B?b0N5VDhZQlpXNFUvSmhmM2daODlwbWs5RlFYNnhXMTB1SGZTRm8xbXpIQjRX?=
 =?utf-8?B?TE1zNmN3czhTV0RnYWpDbzlXZDhpa3k1cSt6WVJrQ2Naek9lV2FKRXdqS2wv?=
 =?utf-8?Q?k5PLzGZ+ajgIq4U+GFtxtdYt9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Ui9iZitkeEtyT2hvVWdiU2lSRDNDYmNESXhYRGJCS0NaM3pBREtUZGxQWVVz?=
 =?utf-8?B?WDVaZjBCSkRpcVJydm14aitoTStuZDRYNmNrb0VFdjhycDJEaEFKcWI2dWh4?=
 =?utf-8?B?VUo2cDRZZm5MdGh1ejhiVWRBRGFaUytxZEtSUDdKZ2RDeENvUUJ1aDNGZjl2?=
 =?utf-8?B?WjdwcjA3TlNhRzhWbG9obXMxVVFodVVxY05lUDRsNTFPVjZsTG9CQ1FwdGtS?=
 =?utf-8?B?d25xTThuT1NWK01yamJ3TUNqWGtldzA2cG42V2JJcDJuOU9hbDFNcXE0azF4?=
 =?utf-8?B?eC9LRzRxQ1BYNVJLMlFvOWRaS0E5NFg4MGhkQVMrTFg1b2dBdWJseXJZTGFr?=
 =?utf-8?B?Vm9wbHNLUlZ4MUp0RVB1Z0hrQkg2YWxqSG9yWWhHcEl5MGs3Nk81bnU2S2RU?=
 =?utf-8?B?Q0RUaktNUWwza0VKODAyQm1sbXFXRFYzN1U0dHF4V1NYZ1ViQXR3ZG9YaVA1?=
 =?utf-8?B?eDBPSnVrdmhZV2NSc01qcUhkbk5XYmVqOWY3ZWhKUnlaT1F2cVhhRVRRTnhj?=
 =?utf-8?B?L3RieFBGR2ZEWGRnRHhiOGEwVXAyT012NWVEYmNTNHcwWFdMdVMvbExScmN0?=
 =?utf-8?B?VXg3Mm1ySVp5OHp0VTlzOTc1a2lOKzhVU2dQREg0MTNvMVgyT1phanJvTzRm?=
 =?utf-8?B?bURDUWhnSjdiNkc2Skk5ZWFsTlU2N1krMDE3bFl5WFpTVEdRck5nN2dObkkx?=
 =?utf-8?B?d0JvTXhsVm5NSXZzdTg0eUc5NFFjaW1ONjE4R0t1eHZ0TGpNUm8vejcxTVNR?=
 =?utf-8?B?QjBuSDliSEtrVkIzVnY0SUd5M1R6aGlaZ1NrSElaYkRNTzdPcU9yZm5IcGxK?=
 =?utf-8?B?b3h0MnZmRE5KTmkwbmhKZVdUS0lWT2lkRmdycGlSZHFuUzRtTDZ3cnA5YXFW?=
 =?utf-8?B?UXFrUVFGMFF4dTRJWE9rMWRoMkRBdkRsc2wyVVppTXpQK0lRdzFHWTMvcTFR?=
 =?utf-8?B?R09KczJoV0RmWldvSGF1UUNldUtBQ3RzV0dNU3RlYzY0V0sxNnpIYjJ4QkMr?=
 =?utf-8?B?Vm51UStPaUJrUGEzSk51eXIvbElMWGtvYkwvVHNyZVkvNDRmc1lKSmp4VDV5?=
 =?utf-8?B?aDBpTllPdE9mTCtGWnRadE5ieWFvSGtjNlFHcmY5T3lnRDBNUUFWaVh2UjB4?=
 =?utf-8?B?WG80S2JTVU91VjFEQVJnK08yUUZsMjdwNDNDMFJiUWFCRFJRUFltZGViVkpp?=
 =?utf-8?B?T3NhRlZIbktkVEE4UlBybnVJRTdqTStadCt4K3NxTWxWZWwyY2xFL1VnWFAy?=
 =?utf-8?B?d1hqRHJhQVdXWnF0QWRjZCttWVlCOXBZL1lTMk5RK1c3V1c3QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51ed77a-261f-4142-5293-08db47788080
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4418.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 23:38:28.7434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3l1i8b7UOrozBAISLmDhTTetrxySanCm5t36Vxh5cvg7KKPQg7/wwgoZGtBio3ftnrplwrAgBbAhvIbWTpniqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270209
X-Proofpoint-GUID: AONBYbTyJ4aWFuDNCI1oUlOJjX9OmpFM
X-Proofpoint-ORIG-GUID: AONBYbTyJ4aWFuDNCI1oUlOJjX9OmpFM
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Dan,

On 4/27/2023 2:36 PM, Dan Williams wrote:
> Jane Chu wrote:
>> When dax fault handler fails to provision the fault page due to
>> hwpoison, it returns VM_FAULT_SIGBUS which lead to a sigbus delivered
>> to userspace with .si_code BUS_ADRERR.  Channel dax backend driver's
>> detection on hwpoison to the filesystem to provide the precise reason
>> for the fault.
> 
> It's not yet clear to me by this description why this is an improvement
> or will not cause other confusion. In this case the reason for the
> SIGBUS is because the driver wants to prevent access to poison, not that
> the CPU consumed poison. Can you clarify what is lost by *not* making
> this change?

Elsewhere when hwpoison is detected by page fault handler and helpers as 
the direct cause to failure, VM_FAULT_HWPOISON or 
VM_FAULT_HWPOISON_LARGE is flagged to ensure accurate SIGBUS payload is 
produced, such as wp_page_copy() in COW case, do_swap_page() from 
handle_pte_fault(), hugetlb_fault() in hugetlb page fault case where the 
huge fault size would be indicated in the payload.

But dax fault has been an exception in that the SIGBUS payload does not 
indicate poison, nor fault size.  I don't see why it should be though,
recall an internal user expressing confusion regarding the different 
SIGBUS payloads.

> 
>>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>> ---
>>   drivers/nvdimm/pmem.c | 2 +-
>>   fs/dax.c              | 2 +-
>>   include/linux/mm.h    | 2 ++
>>   3 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
>> index ceea55f621cc..46e094e56159 100644
>> --- a/drivers/nvdimm/pmem.c
>> +++ b/drivers/nvdimm/pmem.c
>> @@ -260,7 +260,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>>   		long actual_nr;
>>   
>>   		if (mode != DAX_RECOVERY_WRITE)
>> -			return -EIO;
>> +			return -EHWPOISON;
>>   
>>   		/*
>>   		 * Set the recovery stride is set to kernel page size because
>> diff --git a/fs/dax.c b/fs/dax.c
>> index 3e457a16c7d1..c93191cd4802 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -1456,7 +1456,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>>   
>>   		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
>>   				DAX_ACCESS, &kaddr, NULL);
>> -		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
>> +		if (map_len == -EHWPOISON && iov_iter_rw(iter) == WRITE) {
>>   			map_len = dax_direct_access(dax_dev, pgoff,
>>   					PHYS_PFN(size), DAX_RECOVERY_WRITE,
>>   					&kaddr, NULL);
> 
> This change results in EHWPOISON leaking to usersapce in the case of
> read(2), that's not a return code that block I/O applications have ever
> had to contend with before. Just as badblocks cause EIO to be returned,
> so should poisoned cachelines for pmem.

The read(2) man page (https://man.archlinux.org/man/read.2) says
"On error, -1 is returned, and errno is set to indicate the error. In 
this case, it is left unspecified whether the file position (if any) 
changes."

If users haven't dealt with EHWPOISON before, they may discover that 
with pmem backed dax, it's possible.

Thanks!
-jane

