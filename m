Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E26500804
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 10:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbiDNIMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 04:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbiDNIMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:12:46 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439FF26136
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 01:10:22 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b16so4604569ioz.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 01:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=80GuG9Z2OB5edjjpunkIyc1yhfEaarhhzGyq+14i704=;
        b=M5KQ7mfZv6mFYhtnrBqG00dB7LnKFIRZKqw/pvrepjt7LV24VvlIxp5D7/Zz+9yyXR
         pcPjKG43Q7cC/d27eRU9Uby1RPUAJagk37XLqjEYf0jrR3uZ0NTRg/BqxNix5DT830yN
         blUsYDqUPI6g4xemqC5mcga57q1wFsimEU2d4ClWinFeFdloxNm4+KyNvyrmWGeB7TnC
         xOngQ5jnzDeIF3XJ7SWRDm7xX90JSeRdnTrSeQO2u/JsNzoe4X1kiUvv2BWKzItBFiOn
         VNF2kjjlqE1CGO8JP7USrdhkvHGrgL56OIwU5At1X5HRheWcOfAqA91iYGuCnSiVo0A1
         mlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=80GuG9Z2OB5edjjpunkIyc1yhfEaarhhzGyq+14i704=;
        b=02GKB/sIfXwq+JJlnUhu9atapgT2CPdTEAnTT7Uk08M2iU1f2L7qy62SIHu/fmfuzI
         iJAWr3NGUTTIVnBCB3Y+np3skTU57MZhUfOpPoMhyNDK69aGIKR8aWrp1Z+YymiuGJLC
         njd5X8MsZvJfjXflLdaVlX0kjZkw3S/TQ+9GHEgQicUaJzmDorqCliUV3MmrmFwuPHUt
         R+DOQSURXPYHI1rmRUgZii+SkTti2tbuBcu6er3K8dMDPD4bAjl+tnEF9YLoo3+vqhjN
         gyuU0ajd+yOK8EYcuHl50Cp1rJIgMvAzpparWkrz/0HxmXxkG3pegDfsiXPTeDJ4UaVh
         iB+A==
X-Gm-Message-State: AOAM530LGOknAYEUxnqhDRKYf8AGf5smFeuZIwk7LCu0BoEh/xhJRFrC
        i3i0uBVzU9NGeDlssuUxbeXmXdskW2YkIWXjVR++jQ==
X-Google-Smtp-Source: ABdhPJyQyyUIJu7HSaI/sHH6jgGH90kBT3f1SyDRMUnKe+RNtKh/8DVg+hrLhzrO3qrrF7NYPZxCyZP+Y63gqiTXviI=
X-Received: by 2002:a05:6638:3e8f:b0:326:72cb:2b49 with SMTP id
 ch15-20020a0566383e8f00b0032672cb2b49mr715190jab.247.1649923821659; Thu, 14
 Apr 2022 01:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com> <YlLS47A9TpHyZJQi@B-P7TQMD6M-0146.local>
In-Reply-To: <YlLS47A9TpHyZJQi@B-P7TQMD6M-0146.local>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date:   Thu, 14 Apr 2022 16:10:10 +0800
Message-ID: <CAFQAk7iUuaUL40NGzOkCOL=P9d6PgsDjRoKLs_5KDycaA9RQ4w@mail.gmail.com>
Subject: Re: Re: [PATCH v8 00/20] fscache,erofs: fscache-based on-demand read semantics
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com,
        tianzichen@kuaishou.com, fannaihao@baidu.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 10, 2022 at 8:52 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> On Wed, Apr 06, 2022 at 03:55:52PM +0800, Jeffle Xu wrote:
> > changes since v7:
> > - rebased to 5.18-rc1
> > - include "cachefiles: unmark inode in use in error path" patch into
> >   this patchset to avoid warning from test robot (patch 1)
> > - cachefiles: rename [cookie|volume]_key_len field of struct
> >   cachefiles_open to [cookie|volume]_key_size to avoid potential
> >   misunderstanding. Also add more documentation to
> >   include/uapi/linux/cachefiles.h. (patch 3)
> > - cachefiles: valid check for error code returned from user daemon
> >   (patch 3)
> > - cachefiles: change WARN_ON_ONCE() to pr_info_once() when user daemon
> >   closes anon_fd prematurely (patch 4/5)
> > - ready for complete review
> >
> >
> > Kernel Patchset
> > ---------------
> > Git tree:
> >
> >     https://github.com/lostjeffle/linux.git jingbo/dev-erofs-fscache-v8
> >
> > Gitweb:
> >
> >     https://github.com/lostjeffle/linux/commits/jingbo/dev-erofs-fscache-v8
> >
> >
> > User Daemon for Quick Test
> > --------------------------
> > Git tree:
> >
> >     https://github.com/lostjeffle/demand-read-cachefilesd.git main
> >
> > Gitweb:
> >
> >     https://github.com/lostjeffle/demand-read-cachefilesd
> >
>
> Btw, we've also finished a preliminary end-to-end on-demand download
> daemon in order to test the fscache on-demand kernel code as a real
> end-to-end workload for container use cases:
>
> User guide: https://github.com/dragonflyoss/image-service/blob/fscache/docs/nydus-fscache.md
> Video: https://youtu.be/F4IF2_DENXo
>
> Thanks,
> Gao Xiang

Hi Xiang,

I think this feature is interesting and promising. So I have performed
some tests according to the user guide. Hope it can be an upstream
feature.

Thanks,
Jiachen
