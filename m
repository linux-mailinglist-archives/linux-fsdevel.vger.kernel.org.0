Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1306C2406
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 22:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCTVnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 17:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCTVnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:43:04 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8780A24BE6
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679348552; x=1710884552;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bxVzq8suDNih9SH1Ok62kaz7FvxQWlE5bz197aYsbjU=;
  b=GbuTAhxwlUkM8A5pS4ObK/w98dd3S5MoyanjbydheZpn1WVWfRchIHP+
   zIuPn/i/8EKFpRNA034iwFcL7cms4jP3KdFkxQD6exbhb37Zgr51w7CFF
   j5X2ouxVYhGtneMEJ96FOGWL0R2/kybVlS07Dy0y1v7EWH3E8htFJhJrW
   33m7nXL6vingJr0WpTSVH33YyqKUvig5ZH3EpIIkenI6KdrphBDNX2fid
   0AD9mexyk+s5aQwieFjXoq4b8MpIKZGi+gjJZJzoX5WCPDc/L4/+fMegC
   kl3VIOsvFehcGydFGgOGe9wSyXgaPUYEHLl+K3TBc6AYUwZ2QKUQzrK3f
   g==;
X-IronPort-AV: E=Sophos;i="5.98,276,1673884800"; 
   d="scan'208";a="231047319"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2023 05:39:07 +0800
IronPort-SDR: 4qsOQvgbcCrW7nR82xRvXTdZkpAPF7oXzd/XUmIRMWlximryzocpjfhY0tIh+xBF/YraqzUlQg
 0Q4dHTFr+Q7wBu7noGsdNlJydKCDySjiltREQaNsd2J9Ie8xyADEXQlG1LrFCcstvam0h2P+Rn
 uDSDNc5X4BsWl/15Evfuns87ZfAQzyRaHpvPJjOsi9TfUfoxijE3ffwBYavg2zOx7VoiWkB/99
 2w/Jj2XGSAumoj8ilqljg2EWp1QVqjKCxQoAjb2+iOczTMvhsjwfkNu6dqkTYYphUeaKoqgg8m
 i78=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2023 13:49:46 -0700
IronPort-SDR: qFUTwf33oAtZF/zht877Jw/SnyzIUOzI+sxebITdHxZQAAVkERfmqviCTOsV+990RJP9jJpeDH
 15O8l2ioeOdZ3vO3ppfEtd8U0OzAn7IN4WnzMYqrrS1SS6w5l3SCoS/r7hbqtumTLCDXplEQ4x
 BaZhb/mYPP0tHD3eFxldNMJEpeYPU0TTo6R6Uqf5rv7rtLhSWqkNyWBBfpya2vcAbf5Jnv69sJ
 OdyTbHQY7vmU0jjaWm/HHBaIKvUrya/O1jwdk0cUFbKlgCzbvSH+rAFYtiDEcyFjbU4GkH5q0J
 Grw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2023 14:39:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PgSmW1C2Zz1RtW0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 14:39:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679348345; x=1681940346; bh=bxVzq8suDNih9SH1Ok62kaz7FvxQWlE5bz1
        97aYsbjU=; b=EKxs8rpUot/qFRHAvND09IIAv6cqU/2Lev47PpifnoY6Vn42PvZ
        bLqMSLk5W+AyQuqTGKwodJfY4iDfhinl9cyIK7N2mtXEWEbGsMTiKxFf0DCuYwfv
        U7tD4WDxe1pbv3HNUfmVAdcHrTAMKvexZTU0GM1jYO4oNPGmPiD77lxKs2Zw8Hzb
        PwIdTneUr52J5sAiu9A7XMDGoEBHZesZf8Ek4BS/umk2gVFaA1nuC+gmt+D5Qto6
        f5pqaIAayhxw2wlTZV+cAvKH6KJ3w/adruI7wi3ZwobRCy9apzq/Jd2TLBhGAwdK
        dxo6IBbJ/jukaj9W89Dx0kqPLMgyapwzAcw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id p-Tz41YNmQgh for <linux-fsdevel@vger.kernel.org>;
        Mon, 20 Mar 2023 14:39:05 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PgSmM4CNrz1RtVm;
        Mon, 20 Mar 2023 14:38:59 -0700 (PDT)
Message-ID: <2229e074-d78e-3bd5-bf06-a53e9ad57d02@opensource.wdc.com>
Date:   Tue, 21 Mar 2023 06:38:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND,PATCH v2 01/10] kobject: introduce kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, richard@nod.at, djwong@kernel.org,
        naohiro.aota@wdc.com, jth@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230320184657.56198-1-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230320184657.56198-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/21/23 03:46, Yangtao Li wrote:
> There are plenty of using kobject_del() and kobject_put() together
> in the kernel tree. This patch wraps these two calls in a single helper.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -add kobject_del_and_put() users
> resend patchset to gregkh, Rafael and Damien
>  include/linux/kobject.h |  1 +
>  lib/kobject.c           | 17 +++++++++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index bdab370a24f4..782d4bd119f8 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -111,6 +111,7 @@ extern struct kobject *kobject_get(struct kobject *kobj);
>  extern struct kobject * __must_check kobject_get_unless_zero(
>  						struct kobject *kobj);
>  extern void kobject_put(struct kobject *kobj);
> +extern void kobject_del_and_put(struct kobject *kobj);
>  
>  extern const void *kobject_namespace(const struct kobject *kobj);
>  extern void kobject_get_ownership(const struct kobject *kobj,
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 6e2f0bee3560..8c0293e37214 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -731,6 +731,20 @@ void kobject_put(struct kobject *kobj)
>  }
>  EXPORT_SYMBOL(kobject_put);
>  
> +/**
> + * kobject_del_and_put() - Delete kobject.
> + * @kobj: object.
> + *
> + * Unlink kobject from hierarchy and decrement the refcount.
> + * If refcount is 0, call kobject_cleanup().
> + */
> +void kobject_del_and_put(struct kobject *kobj)
> +{
> +	kobject_del(kobj);
> +	kobject_put(kobj);
> +}
> +EXPORT_SYMBOL_GPL(kobject_del_and_put);

Why not make this an inline helper defined in include/linux/kobject.h instead of
a new symbol ?

> +
>  static void dynamic_kobj_release(struct kobject *kobj)
>  {
>  	pr_debug("kobject: (%p): %s\n", kobj, __func__);
> @@ -874,8 +888,7 @@ void kset_unregister(struct kset *k)
>  {
>  	if (!k)
>  		return;
> -	kobject_del(&k->kobj);
> -	kobject_put(&k->kobj);
> +	kobject_del_and_put(&k->kobj);
>  }
>  EXPORT_SYMBOL(kset_unregister);
>  

-- 
Damien Le Moal
Western Digital Research

