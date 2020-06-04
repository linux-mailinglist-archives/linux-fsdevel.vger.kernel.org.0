Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3551EE679
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 16:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgFDOSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 10:18:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48028 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgFDOSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:18:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054EIRhq153739;
        Thu, 4 Jun 2020 14:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=DiGnbIQl397ymT29A/hjjydb/5kljTpmcoBrb79daus=;
 b=uMhvVkOwavGx/ZRY+B3xe7qj/yGzFPw57Mk+UWfkjt3L93NOtWG3w30oylnSE9ohQoai
 mkdxKj8XnTncg3NC6Rj86Lv/1CE8c8+AJlrQy3J/eVsl5TI/pkLwKhVB2WhhKuEIZG2C
 brkSQeBunuee73ilk8iE/Wo8Om+e+7jBaRU8yB6/EhuJr8KKRUN1Re2iVkvaBuZQqdNP
 dbn5UxrAM6bCRAwmF5OK6jenhFLQtEp+VdmFQC7TWLf1G17kC3mE7wSQnWzGRTBHM5bl
 oDFjvffJAUUCV8WKad7MKCC+bmrMej8LJxy3qp8NQgto2WK7z0nzlPltOv0SoxpEpgzr 4A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31ev96t039-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 14:18:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054EI53k141605;
        Thu, 4 Jun 2020 14:18:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31c25vctjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 14:18:25 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 054EIOHL013944;
        Thu, 4 Jun 2020 14:18:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 07:18:24 -0700
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Don.Brace@microchip.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        don.brace@microsemi.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCHES] uaccess hpsa
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wo4m7w6r.fsf@ca-mkp.ca.oracle.com>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
        <20200529233923.GL23230@ZenIV.linux.org.uk>
        <SN6PR11MB2848F6299FBA22C75DF05218E1880@SN6PR11MB2848.namprd11.prod.outlook.com>
        <20200603191742.GW23230@ZenIV.linux.org.uk>
        <yq18sh398t7.fsf@ca-mkp.ca.oracle.com>
        <20200603205450.GD23230@ZenIV.linux.org.uk>
Date:   Thu, 04 Jun 2020 10:18:21 -0400
In-Reply-To: <20200603205450.GD23230@ZenIV.linux.org.uk> (Al Viro's message of
        "Wed, 3 Jun 2020 21:54:50 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=1 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=780
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006040098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 malwarescore=0 priorityscore=1501 cotscore=-2147483648 impostorscore=0
 spamscore=0 phishscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=822 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040098
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Al,

>> I don't have anything queued for 5.8 for hpsa so there shouldn't be any
>> conflicts if it goes through vfs.git. But I'm perfectly happy to take
>> the changes through SCSI if that's your preference.
>
> Up to you; if you need a pull request, just say so.

OK, I queued these up for 5.8.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
