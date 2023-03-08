Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDF26B0A6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 15:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjCHOEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 09:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjCHODT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:03:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6145B5BDB9;
        Wed,  8 Mar 2023 06:01:17 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328Ct2LF002620;
        Wed, 8 Mar 2023 14:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=W7pu0BjMNvv0R8uv+TNLj8Ly3OYFDM7vNmLiZfeEzOc=;
 b=j3CIlcyJJy71GIrbe3n1fGWyhfyTmULltfmNcUhnJGBsJT7wM8TtGt8Ue1RWSRmwSUMG
 qqozUGOFReBhg3uinoPzgQRZ3cIdVTiXvK97ur+tLSBEJXaBuBVzblqGpr1oIkU8m8z1
 ZieweGAYGNsY2iK7ypAfAP4/BxS8jxPm9QhUZPfM+/T284kA32NigkX2MqEFxFxvGgo/
 GuJ2xS6e9nnkYuTE9Hph5aU1MnVWqswIQoT1gLfeV5fk2hIaCJhGJByKKe102fSCh5kd
 /dmIFfkl0OqRyxTxoOxPvH1SliyYek8KyGpeYl98Jib0URaobWfApu3toSFiB/Ur58cx Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6rh34y0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 14:00:39 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328DvXcF018605;
        Wed, 8 Mar 2023 14:00:38 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6rh34xxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 14:00:38 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 328B7Xp7009306;
        Wed, 8 Mar 2023 14:00:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3p6g1gkbyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 14:00:35 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 328E0Yjp7995904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Mar 2023 14:00:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D8B758055;
        Wed,  8 Mar 2023 14:00:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46CD75805F;
        Wed,  8 Mar 2023 14:00:32 +0000 (GMT)
Received: from sig-9-77-134-135.ibm.com (unknown [9.77.134.135])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Mar 2023 14:00:32 +0000 (GMT)
Message-ID: <1d02222998cf465fa7080ffb910bcf5815b7f857.camel@linux.ibm.com>
Subject: Re: [PATCH 23/28] security: Introduce LSM_ORDER_LAST
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, dmitry.kasatkin@gmail.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        jarkko@kernel.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 08 Mar 2023 09:00:31 -0500
In-Reply-To: <ee5d9eb3addb9d408408fd748d52686bd9b85e24.camel@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303182602.1088032-1-roberto.sassu@huaweicloud.com>
         <a0320926ebfe732dabc4e53c3a35ede450c75474.camel@linux.ibm.com>
         <ee5d9eb3addb9d408408fd748d52686bd9b85e24.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8_rl_RBJXHXHcxsBcgBlMoDaw6c84CM7
X-Proofpoint-ORIG-GUID: pLzRE0E0ZuhY9RwOOy5fFbGbISeJZHiF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-03-08 at 14:26 +0100, Roberto Sassu wrote:
> On Wed, 2023-03-08 at 08:13 -0500, Mimi Zohar wrote:
> > Hi Roberto,
> > 
> > On Fri, 2023-03-03 at 19:25 +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs willing to be
> > > the last, e.g. the 'integrity' LSM, without changing the kernel command
> > > line or configuration.
> > 
> > Please reframe this as a bug fix for 79f7865d844c ("LSM: Introduce
> > "lsm=" for boottime LSM selection") and upstream it first, with
> > 'integrity' as the last LSM.   The original bug fix commit 92063f3ca73a
> > ("integrity: double check iint_cache was initialized") could then be
> > removed.
> 
> Ok, I should complete the patch by checking the cache initialization in
> iint.c.
> 
> > > As for LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled and put
> > > at the end of the LSM list in no particular order.
> > 
> > ^Similar to LSM_ORDER_FIRST ...
> > 
> > And remove "in no particular order".
> 
> The reason for this is that I originally thought that the relative
> order of LSMs specified in the kernel configuration or the command line
> was respected (if more than one LSM specifies LSM_ORDER_LAST). In fact
> not. To do this, we would have to parse the LSM string again, as it is
> done for LSM_ORDER_MUTABLE LSMs.

IMA and EVM are only configurable if 'integrity' is enabled.  Similar
to how LSM_ORDER_FIRST is reserved for capabilities, LSM_ORDER_LAST
should be reserved for integrity (LSMs), if it is configured, for the
reason as described in the "[PATCH 24/28] ima: Move to LSM
infrastructure" patch description.

> 
> Thanks
> 
> Roberto
> 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  include/linux/lsm_hooks.h |  1 +
> > >  security/security.c       | 12 +++++++++---
> > >  2 files changed, 10 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > index 21a8ce23108..05c4b831d99 100644
> > > --- a/include/linux/lsm_hooks.h
> > > +++ b/include/linux/lsm_hooks.h
> > > @@ -93,6 +93,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
> > >  enum lsm_order {
> > >  	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
> > >  	LSM_ORDER_MUTABLE = 0,
> > > +	LSM_ORDER_LAST = 1,
> > >  };
> > >  
> > >  struct lsm_info {
> > > diff --git a/security/security.c b/security/security.c
> > > index 322090a50cd..24f52ba3218 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -284,9 +284,9 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
> > >  		bool found = false;
> > >  
> > >  		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> > > -			if (lsm->order == LSM_ORDER_MUTABLE &&
> > > -			    strcmp(lsm->name, name) == 0) {
> > > -				append_ordered_lsm(lsm, origin);
> > > +			if (strcmp(lsm->name, name) == 0) {
> > > +				if (lsm->order == LSM_ORDER_MUTABLE)
> > > +					append_ordered_lsm(lsm, origin);
> > >  				found = true;
> > >  			}
> > >  		}
> > > @@ -306,6 +306,12 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
> > >  		}
> > >  	}
> > >  
> > > +	/* LSM_ORDER_LAST is always last. */
> > > +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> > > +		if (lsm->order == LSM_ORDER_LAST)
> > > +			append_ordered_lsm(lsm, "   last");
> > > +	}
> > > +
> > >  	/* Disable all LSMs not in the ordered list. */
> > >  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> > >  		if (exists_ordered_lsm(lsm))
> 


