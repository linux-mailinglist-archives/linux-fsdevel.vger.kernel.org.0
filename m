Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F284B35B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Feb 2022 15:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiBLOxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Feb 2022 09:53:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiBLOxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Feb 2022 09:53:50 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2129.outbound.protection.outlook.com [40.107.21.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ADE24589;
        Sat, 12 Feb 2022 06:53:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQuVk8oPLE36p5OBLlR6ScUW89d1PNmeAjN/3zTBbpU92Vd5ct/fyUgtClHM0wZLZyNQNi5uLZWFZjj5c0WQoODb/sTOx8DlVFaxQgIcXlGUc8t8vNtzJkSL7kJNnNpLisn76al+GNpcMYa/QiSomrZZWy/EkPRUxxganWnI/6BRAqOfqJ3XLE6xbmCh1mkPSYMfkPQVBcuCTBtvppSy/Q6jvPGTomG5yOZANbG+8VC/KFD+hYNnAhBHuhwXu/sSe/WWkvFZQFEbMLXnpq3+GZpNYBeEfYQF7S5Grd0j0RSm4+OnO3BsWfOgOhvo5NlzUap9pqQ534RH7NovmG/DyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYIkpx5iU0bP4mQUDuFK8X9j548eP27LTxCkCR1xwiE=;
 b=V+zp52YVn96Ejn6+9D+syCBmxsV6ZAAKfebbPmhKDJFUdonFxkPaWLVobAyVFbUaO6YMWspxszC0Mu16ZTcy85gEQeOgMns/OmQv7IO53W2vhMzTsI3gMSUXushOxlJ6HfSkGzRHNd+Oh4P5NkvAuhbJc6k7UZxn1DJ98RoIaQI6ZywrDaYl2wJO7CmSowWLFhln5/gavObRnfK1DTcSkb+C9JUI/uzPlO9ZO3oywVScBy1ldBv3qg7bFjjhgx3MWiBZnsu2JND6BHymd0pjGOcFRjZT917jTKtqd8AUEM0y0f94hupS3B43QI78xFEavjV/Fxn9vfFAebl/3vvasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugent.be; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYIkpx5iU0bP4mQUDuFK8X9j548eP27LTxCkCR1xwiE=;
 b=RMUslwrFm1vW74Oc8RBTpsmxlms6dRnbz8wUOspavz5i+LBZXGmpfcfMz3qW3aM7PgLSmSZKOxUwbZqzhc6++X4aJUqf1uSBb/OyPqFs6zIOpRV4ul1FlttKvqi/Vc6pI7o8JtYFuNI7RM3bNKlOi4BO+OTZWyt3Xi4FvpP3HoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ugent.be;
Received: from AM0PR09MB2324.eurprd09.prod.outlook.com (2603:10a6:208:d9::26)
 by DB8PR09MB2970.eurprd09.prod.outlook.com (2603:10a6:10:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Sat, 12 Feb
 2022 14:53:41 +0000
Received: from AM0PR09MB2324.eurprd09.prod.outlook.com
 ([fe80::b115:2e4e:1623:f624]) by AM0PR09MB2324.eurprd09.prod.outlook.com
 ([fe80::b115:2e4e:1623:f624%3]) with mapi id 15.20.4975.014; Sat, 12 Feb 2022
 14:53:41 +0000
Message-ID: <e1d7ad05-5ffd-dd20-6e29-54c8b0b51593@ugent.be>
Date:   Sat, 12 Feb 2022 15:53:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        linux-fsdevel@vger.kernel.org
From:   Niels Dossche <niels.dossche@ugent.be>
Subject: [PATCH] fs: update outdated documentation about i_mutex lock.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::16) To AM0PR09MB2324.eurprd09.prod.outlook.com
 (2603:10a6:208:d9::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17922c13-ec50-4dd6-f59e-08d9ee377585
X-MS-TrafficTypeDiagnostic: DB8PR09MB2970:EE_
X-Microsoft-Antispam-PRVS: <DB8PR09MB29709E395F1FF11834EF14E788319@DB8PR09MB2970.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWWGEYy7IyFcStpI0/70XiAOjvX35lYIgOqvOOehUfFZm5wsG996TGBGTwO9oYg822W6PXOfbQLMyZSYTxJT20NJWRILfLaM61/72ZWvQgsZfPyKxF0mIcAmui+ujMXLSbT/ckCmL8WxbCpbNi9IUbKtckI5pkMnp8QZWYuzUQ8i3ijflwodD51Ns/qP4LIaqbkgxN+4EWMDlzD8wFoGo3XE9ph+MiDG2FU16g9LTEb5cdF9eBjT6J9QtVmbj0UBZC7402olUJANOUH/l62ihZ+k0Pny1F1n9FhAL7XsKATzEz0ulaS0wnmm4Kp6fKtUHUoonzahK3wepxTd8tyCgpifQUtTsB3t4AeXKSdowg1HSft6909Xg/Wqr/vBVW6VpgI+z2QHcyJ+9gGY5T2lEqt8wPlP+6u+gbb6DerEoP+3fneni8uJUjjP0Hxkwlk7bY0P/OpLu3A+J8GbFHFn9/+FVSCAtBPXceZv5wEFh/2H3NnKlBBXBz9IlPqaTwU3O9sp++09CQ6fWXUQb3jGXgkrjTLE61KVKLAnmjkYvutLxv+quI2YpLWfejxXYw6HyF8vhbKn3sKi2Ao8xxXSlUNAb6B7CLCAm3Tbthvl87fB5U0Bj9DW9KWK3Z8EoV60SvdBEDAWUZ/e88Z8N/3lfVb9sBai0G83NRY7hTVEwc69X/gXlLTGs4Gd4B0Kd/yrhLGqlQG24Ug1BOIIvtIGfMt6xyLiIrDLdguFBVbCg1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR09MB2324.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(786003)(316002)(6916009)(38100700002)(86362001)(8676002)(66946007)(66556008)(66476007)(31696002)(6486002)(4326008)(5660300002)(8936002)(186003)(4744005)(36756003)(2616005)(83380400001)(6506007)(2906002)(6512007)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkJBZTg4WkIrRkphYXYwOXZRYkVhQzBtZThRVUVXcjFsNDFnRkpUbUYzcmla?=
 =?utf-8?B?L3VOR1NEM3FJamxTWVZNaE9TMDFjV3U5bUNOSG56YXhlbTA0TzVXdW16emRJ?=
 =?utf-8?B?TDhCOW5MekRhck5yTDEweTVhM0o0M1lrOEhvMEx4MHR1aVdDSGVqTElSU2RI?=
 =?utf-8?B?cVJLU2hIWTA1eGxJTXA0QXh2VFIySGppMFlwQ0cwSzQ1aFBhTVg2eGxoL1Fw?=
 =?utf-8?B?WSs2TWRVVTQ4Z0R0QjFGbGdueENpandUUzRORFNGT3RwMTBBSnpDeGNRam40?=
 =?utf-8?B?R052ZGNuSjdzbXhuOXhEMlU1WWkwNGpwRUJXc3hVaC9ua3VUM0dOY01XcjBt?=
 =?utf-8?B?WjNMZzdDSGZma20wSjhvSi93RkFZMXJxbGdUR0hvVGZJeGZCOHZ5eUcvV0tP?=
 =?utf-8?B?cU5OOWh1UklxUUl0NGpjWFp4NmJFMEJibE9UNWpwdWZzQndjblc1dUhQdDFU?=
 =?utf-8?B?cnAyelZnNEVyWStPcWp3VWVDbzE0Rk80YUpmQzNiK3c1R25QemFOM212dnNZ?=
 =?utf-8?B?bklIMEpYdU9Ra1dsdW5uaEVYZ05DaXRpRHV1OER1TUFYVnpGQmhvVGlOYXZW?=
 =?utf-8?B?M0RMaGZyMThDNWo4OFhMaUNGZ0lHeVpGZ3dVcFZ2UkIxSUZoR0VwOGZ2K0hO?=
 =?utf-8?B?SjJZZFo5TzBSbG94aTJiWldPZmdncFE2UW1xWmNXQjl3QWsrTlFZTUZ0Y0Q4?=
 =?utf-8?B?b1d0VjdMTWdubG5iTE9NbHBuM29Nd3I3U1FSUktyQUoyNVRFc2QrektvNXRF?=
 =?utf-8?B?bWQwWWFSWEFkNVl3SFRXZ3h2T0RuaHljUFhyZ1FEN1A0VE1BZlRsOFEzMmkx?=
 =?utf-8?B?UDdiaWJFaUkyNzdQOTkzZDYvbmU1S1RFTmtiZDcvOXFIQ28yYk1RUjZVbVhH?=
 =?utf-8?B?Wk1mcm1HQ0dzUTFmZFhXazhPVnY5MVdxeHJuMXBHTGVrSDBIZE96U1NRQTlQ?=
 =?utf-8?B?RGlxeGdtZ0JwSE05MENyb2dxUUEwNWlYdXp1ZWV0bmNoV1BBOGNLcGdzcFg0?=
 =?utf-8?B?RzVsdm4rNFgyWmp0L0VmMlBuT2ZKeGpJMXkrc21kSkVLOGVha0x2Njc0RFpZ?=
 =?utf-8?B?byt0Vk01S1g3Y1hoVVBHdlBpZ0pwbUx6RzlzSVQvVjREcTlPY3RoVy8vamdj?=
 =?utf-8?B?UUE3YkJ6YmNYbk96elZIY3VOWlVzNFlpZzVlUERXaDlDNmdZL1R0Rnk5Tm1R?=
 =?utf-8?B?a2ZoWksyWi9wYU12dC8zL0pNZFpwQitQU3RydGp5dk9HV2dGb0FGOWJHaWRn?=
 =?utf-8?B?dmdvUW1KaHVtVjQ1RnRFbWJOWUxuTllJNUg4eTRJL0I1RU9NVlV2akFJZGhs?=
 =?utf-8?B?dnRIRmVpTnNEUUxNdGNsYzFrbzVkNWsrb0RzSmExS2VzanhhbU9yUEdyS2RQ?=
 =?utf-8?B?YTlkeEpTWWllalFSbWk4aTZaTlBNWnNaUHc2RUQ3cWFZUUZWaVRiSlVvbFZ6?=
 =?utf-8?B?c1lnSGswYmliTHFSUitRRnpBTkJ0ais2V042czM2dmJTUk5BOWYrR3dKSTRo?=
 =?utf-8?B?eDE4R2s1QVFHbldOV2tKbUpQbk5iMHo0OUNYdWhFbjRzQ0ZYbXY4Vkdrem1i?=
 =?utf-8?B?UXBuZ2IvTTBoR3ZGMm5USTcycTI1WlpzNXRaUC9kVGtXSHJFc0RUajFaQWhK?=
 =?utf-8?B?eUhyL3NvUUd6WTc4UWlqMFVmR0MvSVJkREJEMTdpR0p3RVp3M0FKYVRETTg3?=
 =?utf-8?B?ejVlMkdYWDM5SjJxRDZmaGdqWjcvL1I5T21YUlBEKzgzVzZqdjJJVEJWZk1k?=
 =?utf-8?B?ek56T1hwU1Nmd0xsc0hZa2srTHE0WXhqNDB1a09RRnoyZjRIYXZkQmdXWlJF?=
 =?utf-8?B?RHc4YnZQaDQ3RW80ak5RUkNEc0h6V045VCswdFFMMDQrQlkrZnBXY0ZmVXh2?=
 =?utf-8?B?cnFvRjZVRENDcUJRVnlDeFFKaHlGUUtvRFBaaTVtMGlwSXRnSG45L1dUZUFI?=
 =?utf-8?B?eFh5R3RBWHE3VFlMYndSck01TUh2UjNNZE9odTJFcjltNGh3aWpvNWJVNHdw?=
 =?utf-8?B?TFh2MjRrZnlYUm9LTHJyRnJ4aGRkelY1TTA4dURvMHhIT25BcmRudXhTQWRT?=
 =?utf-8?B?WU44dmI2bjRkY0Fjc2JacUNMRWFrSUFuWlBzNVU0cEZzZEI1U3BxdVNzY2ZB?=
 =?utf-8?B?MjU1eEhTWUxQTjhiNjF1ZVA1Vklnb1BLeVlWTXpmSHJaS3I0d0RuRVJWUWZZ?=
 =?utf-8?B?R2pabWVvSlE1MnkxeDRINGk1WmhBUGJBZmp0djBQWFdJV0lUZXY2clNkeDRF?=
 =?utf-8?Q?n5xFOCqtiQJkcFnAMR5cJuUX4EB8Nq+UNXJgdBW2Ms=3D?=
X-OriginatorOrg: ugent.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 17922c13-ec50-4dd6-f59e-08d9ee377585
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2324.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 14:53:41.4773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d7811cde-ecef-496c-8f91-a1786241b99c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6pS9vWU5Z6O6aRFetSsu4AFU8eQAKDWTgKg+2F/rv8IU42Lo5gw31AsDNfKXBDVr2CAAk6LSj4IYODh68EWOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB2970
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This field was renamed from i_mutex to i_rwsem and now resides in d_inode.

Signed-off-by: Niels Dossche <niels.dossche@ugent.be>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3f1829b3ab5b..abf454f12365 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2692,7 +2692,7 @@ static int lookup_one_common(struct user_namespace *mnt_userns,
  * Note that this routine is purely a helper for filesystem usage and should
  * not be called by generic code.
  *
- * The caller must hold base->i_mutex.
+ * The caller must hold base->d_inode->i_rwsem.
  */
 struct dentry *try_lookup_one_len(const char *name, struct dentry *base, int len)
 {
-- 
2.34.1
