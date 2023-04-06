Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D38E6DA3B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 22:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbjDFUmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 16:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbjDFUlw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:41:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334DE9EC5;
        Thu,  6 Apr 2023 13:38:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336F23uP008734;
        Thu, 6 Apr 2023 20:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HIpmieGP833Z476Gd6basWxyw9yeRwHd2EZy2Tgk2DQ=;
 b=t/4R0P4Tp2O86Gml12kTmC8gUsB0Nw5mSBUJNkZYrACKUQgJJuwwhSwRURstSA8EyKIH
 6VrakfVYIeccepy4II0Ht3JJGq3+FDSZBk/ts2SmXJrTdJX4LmM7lpKLRcxWBOPH9ukB
 RdlECW2Isqp70BXnBaRLC7jsd2u10sZKbP2wr5fhtlTzAiPYB4TKww7av8BJB3gBsQR8
 fm+yvm2dzCyV4L27xEvxKz4gssWUY74tEm7GxHGty9XkALEK46LGup0IKtuJnG1hYWf2
 cgOhuiV313Vdp4WIfrN6yeBtV8f3zerhmZHzKyKKp8t+QSwS9yPOIb+0IzafHqnM6UgE IA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5ukwvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 20:38:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336Ip4bN036535;
        Thu, 6 Apr 2023 20:38:35 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptpau5w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 20:38:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e34Gd/SqQ3Qj0EqLgMfXNPlXuJ9AfNdeK6g8oD9vqT8RWzIpERxmrzSocLyBWX8fx6F/ibhLClstHc0bB8OLCXP4FywIu9cHHpVh/gkjLPG5rgBZMFADkeYrZWBjNnH3N3yZ9sAyfGbjSYOW9eWaURieZrZccsviqaIlhSQih/DSA/eKKalwQCQuwDKpJlfxTs7/hjia89VnU0CmFj1g12eSxrTvjbCK+xA8s6d+N9J2fcPeUC108XfQBTCeAIyZIEEu1dTJC634ID0NUrm+HkerMGTo2i+o23VqhsMs08pucCNxBc8ALoG8+Gum9SPPljipMYPJQGpjmhGUFLOFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIpmieGP833Z476Gd6basWxyw9yeRwHd2EZy2Tgk2DQ=;
 b=HBrX6TDyU0ir2jwbbGHIspr11V2A4fBgp3bvFw4Ler6/2cDoBuOYKzMq2u4ZJBTozfBD+jX+PK9jf1uCvGaHKUuLAjaBuWQ3h+LTrzECSfa8cCWa1ZPFrE8FIkdt17RK218yIeGgVMJuu94sqO9um9TlGIBxJ0i58bEoyFtoBa4/tPCicSDsHKUxfbCVp3jNgbh7ODTpMmWExMQIYEMS03Kaq7YfMl60tPOpm5TqQKQdKLt07MRA2PMpcOTRUuSIoOp6eKQb5lMNx3RYBA7L3U1UWHdG4+HxHrgYFaMdQPZdUtVALuSl1iazH4Tx7vkUZRtozZI3tTOArOzMpkoJCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIpmieGP833Z476Gd6basWxyw9yeRwHd2EZy2Tgk2DQ=;
 b=kIya8Z5N3MV49x3SDCQSjVXhqgwrO93JBNg8tnYAkXpXEPELd28F7HfjabhmIeImhoL2BfgCG0ebRNyRVDAHyONkoL5yPITGER3ncd0mAepaqBMWEmLyu4d//bNKba4cCn3F0ebMcBjLbXhF3Zn8x5HXZkk9E729CGXqk7aUtLI=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MW4PR10MB5776.namprd10.prod.outlook.com (2603:10b6:303:180::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 20:38:33 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9%3]) with mapi id 15.20.6277.030; Thu, 6 Apr 2023
 20:38:33 +0000
Message-ID: <bfca2ab7-fbd3-1e7c-3128-c892c519697e@oracle.com>
Date:   Thu, 6 Apr 2023 13:38:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] dax: enable dax fault handler to report VM_FAULT_HWPOISON
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230406175556.452442-1-jane.chu@oracle.com>
 <ZC8eVmF7YdBsDmc4@casper.infradead.org>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <ZC8eVmF7YdBsDmc4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:806:22::9) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|MW4PR10MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3048ac-030a-4ef4-5cad-08db36dee3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sHJsq3TJB8NItQSr/WpTq7O7UQ8FAF1b3RNJJvBzMX7ncx7Wz9eCQILQo5iu2iah9/w1gK0nYRPVNgkRs1hU3vLnKomis3pLm05v+OX9TA3wrO/4IrykZHE0AgRxuCYNwOk8Bjrooybf/8sVh+4RZc9zhlbDqZwYeZF82621rhekBcnIlv1AGua3oWOfuyKdZes7vyreFybHgUgeqUt7S0fLVJqkEevzq+LCD5JdBC1y4/g+f49zLyK6qmLZu2rDjJiUSWUIXFhSf7EWFxTdlU5x1AlRT2saZnXRkbR0l8ntjN+Ztg8De0Zt7RkA4ti3WOog4CfGbZhiowXzMLwO7aigMdtWYMhwqdzeoRcoX8hQeYRdU8NndTX8QUyz80JzHpBwVk3u83CPmF2U7mTNt0knMzX8yI2mv7ihOgevI7mQqKe9mxI9kGVPIoSUZ/ncVnww7AOFy95CkIpOybcSAe1C/YaqqAaUIlsi9J0f6jWQm2LDbpU1s9I8BfpiHkhYrSpMSOJ+r84KveswtA0Zi1InqVrs/3IVXgDk3zmGH58id2hLvpiNRh/+jek3nhnndQYy0liVjS2YfcCFjVyEc2p6VoKsgiOmgJ/EMjs6mKp9KTCLA8KIKXMmxXAjNchy3ZBDcKRpl/nzE4Zz8NvAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(2616005)(53546011)(6506007)(6512007)(186003)(2906002)(26005)(8676002)(4326008)(66946007)(6916009)(66476007)(41300700001)(66556008)(316002)(7416002)(5660300002)(478600001)(4744005)(44832011)(6486002)(8936002)(38100700002)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG41c0s4VE9qR1JMczlLalJIZjQ0YkNtWjJGUVFlR2sxNFY4dHYxdnQ2cGFp?=
 =?utf-8?B?ZnZNQjNKVFkzeXIweDRKTHFhMjNDNWt5ZXVTYTlEa29tVStleVJpWU1HVzdm?=
 =?utf-8?B?eDc1Z1VxYjIxdFZmUHhuL2JudVJ5MTRYUWNHSzIzQVNiWnNCWERPRXRaUTBC?=
 =?utf-8?B?SGhIam9VQzgyWktzUUI4UXhDU0ZUNmg5Z3RwalBwK0hLME43RUdqTmVxM2Ja?=
 =?utf-8?B?dzJ4S3JVbDYvbEwzWktBdXBHM3FNWTFkSWswQTA4RnV5V2lpM0dWUmhpN3Yw?=
 =?utf-8?B?c1Rlb3JhMVowRkY3cTNCTEhZY2lSMFhLcEl5b0hpU3greElIby9JNFAyN3k4?=
 =?utf-8?B?MEl6eTIvVjNwdmg4dlpqaWR0TU1ZZWYvcWxkN0hGOWlIbS8wQ0ozZUM0bEFr?=
 =?utf-8?B?OVJKN1NFbTczeW83Z3dhd0RyNkJ3Qy9mK1Rzc1QvemFDM1NlU1N6RlVrU05u?=
 =?utf-8?B?dGY1QkxXVlkwaUhBM1QyQ09QN214NWJGaHpraWV3a0JCN0xxaEYyWUtwQi9B?=
 =?utf-8?B?SW5wRnpOekJxU2VFUzlldzlJaVcrMk9jOXlwbTd4dnRyTExabldVSzBaTGZD?=
 =?utf-8?B?dk9DdnNQbEhNTjIyb2loQnd2OHhuYVIyNGpQdDJtTk1NU0pDUWhmNmpWRXZY?=
 =?utf-8?B?VG5xVXFUYWdlYkZPam9IWE1HaWdKelA5MlUvOWx6Wmw4dnZ2d2V6cm4vdjFT?=
 =?utf-8?B?MitqNHUybVR4NzZaNVB6MHBwN3B2aUpneG5iVlhqcU9qbHNhdi90M2xKQ2pj?=
 =?utf-8?B?eWc2M0pXTHN1NU1teEtwTCtKVDRFLzFXQnlldU4zRkVIR0hMRXpQbzYzTTFP?=
 =?utf-8?B?V0ZtbGYzY25lZ1FBcFd2SXJXc0d4bXJabC96YjFOaXMwazEwZzZZUDBzdmtR?=
 =?utf-8?B?YjMxakxhaEdxK2dMaDJDeERmZWdReU42QitjcUd6bWtIbXAzWmIvak0vUUdj?=
 =?utf-8?B?RUMwWGw3blh2ZERyRkk2TmgxZmhrL0FpbHpOVlkzU3Y2eTNQNkxBbWY2eVY3?=
 =?utf-8?B?aDhVNTMyNCtLZlp3ekJrTW03WjhUajlYeUdBQmF2MS9yL3RlT2lNN3dKSTdh?=
 =?utf-8?B?SjRTVzRENnU4L1k3Rm9UWHJ0MWNTYTZJL1hzWkJMMytHOUNWMnhoMkN5ZkJm?=
 =?utf-8?B?blFtaVVXZEZkc2FMenB3SVJBMDVkczMzY0piVDREWS9yUFZ2LzlIUUpPVSt0?=
 =?utf-8?B?SFZzbnR4ZDFUU2hEMUxYbUZqR0xhalFKaDgvbko0SjJ0eDN2ZUVnOEhSVUpH?=
 =?utf-8?B?TUVqa2dpSHdxTGY5REVta0lOVDZteG9ndmYyVnZ0elNXZ0pLZ2M4ZUI1b2Jv?=
 =?utf-8?B?UUlnZGM5QmRIUzJKNU5iUUFRNW14cnFwbHc4N25VYk1vVFpNK3NCUkJOYm5k?=
 =?utf-8?B?OXY0TVRhVzdMRUtEZ09pbmt5UnNDWjJNUng5M3dFaUhVOXhjZlJJM1NGdGRS?=
 =?utf-8?B?d1krZU9FWDJjZFAza1I4SlJlY2s2S1VjVE9MbkplQ25wNm9EYUZwVTAxVzFX?=
 =?utf-8?B?RGpia1A0T1l4WnIzdHQwYkpneG81UWs1ZjA2dzh6SnJYc29RZDVGbG9lNDNx?=
 =?utf-8?B?Wm95Z2g2TzFqTWsvNTNBdDF3VGphNURLZ1dYVjFmL2xFdG5jRytpZkpCS1Bv?=
 =?utf-8?B?UVc2aUY3ZjBNVGZDQjBqOWhLdGdxcURONWJ1R1VBUTBzZmlxUWovekpCQ3Zj?=
 =?utf-8?B?TGtGa3BEMGlZWlFWY0lSUmJDYzg4bjk4cEFuemE2TTJPeTlLYmorMCtCUitC?=
 =?utf-8?B?elpTMXhlYkdDbVpBNTNCRjVsVkxqSkVEeUMwVC9pa3B3aFlScCtUNW5MUEc3?=
 =?utf-8?B?M0RsMnhFeEZTd08yVHpmbHlyOFVEWGJDeXBTZlFOaVJIN3A5V05IZGI3TVBH?=
 =?utf-8?B?YVVHeGlkY3JWTlI1Z2VsZVFjVDNDMDdXYXUvUEVPVEFaKzJkcFNreEF3RkNn?=
 =?utf-8?B?Mk9FSU9JcnJvOWpUNjNWbkkwaEIyZDZkdWFQT0ora1d5NWRPUHI1MU9OdE9N?=
 =?utf-8?B?SWJZcTJoN2N4MEdaME5tZFVhZy9MMHJIY21lK1RqbFJCMm1SWEd3YWcrcS9z?=
 =?utf-8?B?VlVyOUxUQkR3TDdiL3BBQlRPQmxiNDExVWRYeVJpVjMxaUpURERyMDREZzN4?=
 =?utf-8?Q?hIUnlrpeirsYcGW8vksshh4cx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RkVaTko3OWRvVmtKTGp5ZTNVMkdaUlJPUVlMbElpdmZxczd2cWovSlZQVlZX?=
 =?utf-8?B?WHhYSFF1N0RqZGVwKzAwcVNRQmtoNDhjK0tiZ2lIUm1RdWo4YkZpTkdhZndv?=
 =?utf-8?B?YVlCbGxiSDZ3MVEwN2VrV1VKMmNDeGUwZXRTaVZ6VUZUeFZ0dFdObDBBUGE1?=
 =?utf-8?B?WmxtRlVxanhYUlg1ZmErbW1hREFFR1IwbDZDUXhCNVRJMjJiODlmYlFKdi9E?=
 =?utf-8?B?OHViNGM0OW9pNnFUUVdTYVU1aXQ0MXJQSUR2diszT08ra0haeGZydndMNlN0?=
 =?utf-8?B?UDJHMWxHdEtCc09JK3JFZ3BnVVpNQ254eWpTR21NWFkyL2hDNCtVWFBqdDBH?=
 =?utf-8?B?cUZBMndDRkljRWFxYjN2WWhVSHk1WUpDbkxaNjhOQkpkTytUaE0vc05iVWdX?=
 =?utf-8?B?VFdpcjZBVS82aUQyaGVSUFl3U2pUbml6c0h2b252Sk1KaWxvb205QStGb05L?=
 =?utf-8?B?elBXZkdFRi9iM0ovZmx3Y3ZHUHRYejJ0aGwvRHVtUG05bDFPbEw5STR1eDlR?=
 =?utf-8?B?Q09tT252Yzh0SXZjWTJsTHV4YzVXUUgxc01PU096RUZrRUQ3S29GeVFRQkZY?=
 =?utf-8?B?TDY2bFRXa2tFVTVXNm5mT05Cd2FGYm8ySndDckJmVzJBaHlwdnRjUnJ4VGFK?=
 =?utf-8?B?VUQ3MlMvNUVVbzBHSTdHTTZRNU83VHpyWE9tRlNvVUd2ck1QQWx0a2RpN0Ny?=
 =?utf-8?B?UU9iTFRpb0tJdkdUbTZ0UWNaeVV3cEEyR3VPMVd2Q3dSK2Z3bVpSUHBhQmVo?=
 =?utf-8?B?czFvbXM1bUE0dHNMUm1OczFBb1pSM05lSzBBaXkrMDFla2IwK2ZoYk1jUHI3?=
 =?utf-8?B?U2dmai93V1dETk5UZkRsMnlmRE5GOWhTUzJIOVFkbkFwZ2ZIMFF6T2tLZlpU?=
 =?utf-8?B?UlV1djh1SEtLYVVIaXh2RU9jbDNZaUNyMFVLZ3ZZRERudDJCTStsTTdhUWRT?=
 =?utf-8?B?OVc0NHRkeEp6VWRha0Qzem9JcVBFOVpJQUpWenh0ai9XV0pITmJQWmpYRzN5?=
 =?utf-8?B?cDNsZGFNK0NFaDFVNHd3Z2ovNnhJeVNkSTRtd1F4ZEQzWmVmTkJIZ2hZMXFX?=
 =?utf-8?B?SHR4aHkxV2FTbFNkc2lXR0RyaThuL2gxckU5eUJrWFY2UTJIbHJ0SW4zQ0Q3?=
 =?utf-8?B?Mys1SENXbTFUR1QyK0Rvam1ub21iLzI2enZxSGtLL1Q4T2REU3dqcS9ab3l0?=
 =?utf-8?B?NC9aYmw5b1o3S3dlVlR6QmVJWDN1QzlIY09QK2ZPUTVkRmFyUTFqTzNGeU5E?=
 =?utf-8?Q?HNZymQNuAj/Pvvd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3048ac-030a-4ef4-5cad-08db36dee3b1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 20:38:33.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyNnO/SYBUKM6Jwtzo7vFFYyVQzC2axDR0lBd94jIcaFev2vllpqcW4EDMeHkYrgmWYRuwc3Bwb9UafgGVpsYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5776
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=959 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060183
X-Proofpoint-ORIG-GUID: gWE-c6xDTvR2ksumHpIp8HXxlLzQ0WbG
X-Proofpoint-GUID: gWE-c6xDTvR2ksumHpIp8HXxlLzQ0WbG
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/6/2023 12:32 PM, Matthew Wilcox wrote:
> On Thu, Apr 06, 2023 at 11:55:56AM -0600, Jane Chu wrote:
>>   static vm_fault_t dax_fault_return(int error)
>>   {
>>   	if (error == 0)
>>   		return VM_FAULT_NOPAGE;
>> -	return vmf_error(error);
>> +	else if (error == -ENOMEM)
>> +		return VM_FAULT_OOM;
>> +	else if (error == -EHWPOISON)
>> +		return VM_FAULT_HWPOISON;
>> +	return VM_FAULT_SIGBUS;
>>   }
> 
> Why would we want to handle it here instead of changing vmf_error()?

I think it's related to the comment about the the corrupted range of
a hwpoison caused fault - something no need to worry about now.

I will move the change to vmf_error() in a respin.

Thanks!
-jane
