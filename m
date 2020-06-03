Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E461ED7A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 22:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgFCUxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 16:53:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43904 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCUxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:53:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053Kqd8j098636;
        Wed, 3 Jun 2020 20:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=tB6kyVXSO/xYelpfB8+t582Lm8vN6eEHdsj2aRaz8lg=;
 b=YRIPHSuKdiaN05sKUeXyU2HR/sTRQrJBJRw4ykaAhB1BG0bBpEWL6s4nnAyWz9Va9MxJ
 gL13OEYpHKUMgZ3h+CSWxUj8oQA86YQ8f/ygbrDwZO8j3cERD6h8UIUDk56uO2xI9Xbn
 ah2tWyeTVYZEYJod0/t+plGku3EwY7LzbNXmz3tuuLCFTgphDYCM9ax8vTy68wAY9bhE
 KQ1L0xsoj4q17igL3RSnPstEfw2vzOjZf2KkX4EwxhXFHLAVlD6XwpCtWRNdq4U81dHi
 2zQkNGA5QrfVaZ1DmgdfOfIPpTTVRZmWMqbJWsUcYlquaKmB/P1t7dXxmOQGwqmqVKcy tA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31bfembbny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 20:53:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053KlSLb152521;
        Wed, 3 Jun 2020 20:53:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31ej0yb9xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 20:53:15 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053KrDtR015005;
        Wed, 3 Jun 2020 20:53:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 13:53:13 -0700
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Don.Brace@microchip.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        don.brace@microsemi.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCHES] uaccess hpsa
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18sh398t7.fsf@ca-mkp.ca.oracle.com>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
        <20200529233923.GL23230@ZenIV.linux.org.uk>
        <SN6PR11MB2848F6299FBA22C75DF05218E1880@SN6PR11MB2848.namprd11.prod.outlook.com>
        <20200603191742.GW23230@ZenIV.linux.org.uk>
Date:   Wed, 03 Jun 2020 16:53:11 -0400
In-Reply-To: <20200603191742.GW23230@ZenIV.linux.org.uk> (Al Viro's message of
        "Wed, 3 Jun 2020 20:17:42 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=1
 spamscore=0 mlxlogscore=904 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 mlxlogscore=946 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030159
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Al!

> OK...  Acked-by/Tested-by added, branch re-pushed (commits are otherwise
> identical).  Which tree would you prefer that to go through - vfs.git,
> scsi.git, something else?

I don't have anything queued for 5.8 for hpsa so there shouldn't be any
conflicts if it goes through vfs.git. But I'm perfectly happy to take
the changes through SCSI if that's your preference.

-- 
Martin K. Petersen	Oracle Linux Engineering
