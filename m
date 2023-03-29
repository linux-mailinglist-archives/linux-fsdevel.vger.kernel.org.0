Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3C76CF74C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjC2Xdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjC2Xdk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:33:40 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23F612D
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132819; x=1711668819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2XfkCsgwrNyUw6t3bN5epvi5ctQPl/PkBM51tAE2KI4=;
  b=LMb7ynIf5yzQp9hgfiIAuuq6P6O1VqRvfDFdisutKwDBWSVGPXLAZhWb
   jIzAVDeJ2+7WTI/vS830NLQ1Ax/3m8yYKdRVlR1GSIBICwJH8bRzflgbA
   4XdLNYQhEFTzC2nntK78T+TlP9Xn7db2kYBDUegzIScjRBpM9R+eyMXmc
   Rp5XHnizwVVvkrchPiwYnfhWqO1JGyIQEKbX9TPHdPXq0kC5w2Awm/LcW
   wtCuDBfV8r6eqUwJLDlaU88R/yf+UD48kkRxxDtSaAX4hMW9JG4xhzltp
   LZgwonVJvlep946gbx0JC7b2+anR3nxsbA9z4qjehuILkDuvta3z0jj+S
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226648226"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:33:39 +0800
IronPort-SDR: PY8H0K0JPj0DjraF48TImUvYrV4ESQENfD59ioevHy8G61+XfQ6nYmIdF/snUXGSSFbRHgoP+k
 X7N+Ng03LWhWdj0rYMzA98tY8EfFrVpL5DYFaf05YQaGgTI8WaP4uDTEPLgz4Zh8TF9YPhdCuQ
 t2+vsIWmLpZggZmkiuy1DpzvONxWgNUp3iXoF643ri+83n4b1/WKp8pYpxUviIS/6gE9qKvhyu
 60axes4W4bAEbqnel0sfQGyROCZjP9489UTZXOSWv3OsipQpYESdhzxL1H5RAP0SIM49hhmiOj
 k8w=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:44:07 -0700
IronPort-SDR: X2aL/auBqnS0bNATEL72aFD4moItyTLYZ7NGecKXtG82XZPDPH5A5H5fWPNABFTPyA1VkpjgSs
 iql+x6wONT6xnoLf/OaRZHXbLC2fZ2RF4BVBgxRyCvFhZHruVJRcYkJ3Q2bn5+OerectGLj1jb
 XZEGSTfE3yUMMfXvyrJHMpfCUwywTju7DLrxXuTOYHdNtDvmN7DcW+agbSo9XSkq3nStdRyeP5
 UQ0I+I7ZdN0TszdpTuKXyOEgh6pXeTsyIzjOPGl8MgMv/TZTe2/MxWfegPmT21p8nI6Cb9qEtt
 pvA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:33:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2tW18fvz1RtVw
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:33:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132818; x=1682724819; bh=2XfkCsgwrNyUw6t3bN5epvi5ctQPl/PkBM5
        1tAE2KI4=; b=iL0pOV79abCn58O3GsYB3incxhwrPGLAZGI7X+0lqN4SQQeDOnB
        qJb7+62q5R7L5egPIr3c45AiogLxHvyE6Lwb4X+ABQD60bWF9q9d86DXH9mxAomK
        Qu2grIxrBMnxXiUCC9/WpTKWZywUMM3/M8INQgOE8mZwBHEVU6DB5WsHrjzo+Sn/
        1V6s1+NZHPGuYuWBRZO8OSKChosO5Hy1NGf3W1IvjZty3XmVtff6p8XfHJ30Gaoh
        4l9C78DP+cf3gRR2ZbpYL8pkpDSGf79rjnBmncsC+8xVR7xVsQk0BA1KeF40WXti
        HbeBREtOM52B3AwqaTea8N47bzscm0SsNKg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m7F9y5DM4kBt for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:33:38 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2tR3Vpwz1RtVm;
        Wed, 29 Mar 2023 16:33:35 -0700 (PDT)
Message-ID: <922e7921-c70c-cda6-aa5a-07ed44596d4b@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:33:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/19] btrfs: repair: use __bio_add_page for adding single
 page
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <faae16612c163bd6e65cf3d629b0a3c65666821b.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <faae16612c163bd6e65cf3d629b0a3c65666821b.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> The btrfs repair bio submission code uses bio_add_page() to add a page to
> a newly created bio. bio_add_page() can fail, but the return value is
> never checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

