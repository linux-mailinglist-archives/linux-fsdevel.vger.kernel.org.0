Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7753E852
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbiFFOKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbiFFOKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:10:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4B25EAC;
        Mon,  6 Jun 2022 07:10:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n10so29227534ejk.5;
        Mon, 06 Jun 2022 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:cc:content-transfer-encoding;
        bh=zcfwBnYsaM3osnPpLQRxR1JrABrX/zB0kh++woByQVw=;
        b=gEpMt7Yd2UxBYkCte5IR1tgFlFVQEJ5SylH2/PBFk99wiIMXMkM+sU44fPiSwHBSIa
         IMN0bB6BoqeG1sEJlrPjvDJwshD0q/AyS0IJHSN0P9Ag849SN82OU8Ve5PJzspiKPaW1
         ixl/BLksjnyF6+Q+zGJYXDzeZpi/LDj+JclfL1cyrON5hgnvjaUXMyC7nb1ksactUBIH
         jb2tLQZDR3UZzGNzC9dAr2e1XwZYvkD5WfHeYwhKxD+AUN/NVrWM8f/WdIoZfPQ/vOJo
         Hy5xj1R8bnKIgXu+lNCl9xqLdJ5CDltw8jt+jMNUJK7Q1MpOo0KjmNKdY80vONgP9gY3
         g/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:cc:content-transfer-encoding;
        bh=zcfwBnYsaM3osnPpLQRxR1JrABrX/zB0kh++woByQVw=;
        b=ss3fQdadU5gm21exoNWt7o3haLozUczfmXkPubPJabujpQWjlH8XniKWvLOfjBxJPw
         dhzV0q+V6v++/2qb57tbq8uOscmIZ12L8HhM3tfEQ+Qs9S7StNnw/gO+QKmKYVq1jxYy
         0Vd2j15ZZieUrvHokggrKElPc1GuyPXHAB/gWZi8hOz7zrQKRH7iuaCfPjX/78wfg9A2
         PAUaj8OzOv9GCR45D9vUVyk0xxZZ5BXxONJCF3jEod7R+qCJM7AvsI7y6AIDM9WlnacE
         5pOHPDgtXI1AISGq4OFkEAvwv6OBT8Kxp4HqmJm3cYA+FIGp3/sdt1R+xdclT+FP+cwG
         H6kA==
X-Gm-Message-State: AOAM532d8PaRKNM0RkupMzqtzQtcQB0j0dSlYbQw7km3DXWATjhCXi/Y
        qpHp6FpNWxC7wu3QfRO/8is=
X-Google-Smtp-Source: ABdhPJzqBAw+J0OHGwBe1PkTWA7yEhL5aB2O9MeJxPiApU6qXMja7NqcmfnC2G25AjnP5JFxsUOEog==
X-Received: by 2002:a17:907:16a4:b0:711:c9a7:dc75 with SMTP id hc36-20020a17090716a400b00711c9a7dc75mr6290181ejc.542.1654524645895;
        Mon, 06 Jun 2022 07:10:45 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id e1-20020a17090618e100b006f3ef214dc3sm6357044ejf.41.2022.06.06.07.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:10:45 -0700 (PDT)
Message-ID: <a1aab4df-9e1c-793f-5c3d-d735e4f4fb57@gmail.com>
Date:   Mon, 6 Jun 2022 15:10:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: fsdax: output address in dax_iomap_pfn() and rename it
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        nvdimm@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Static analysis with clang scan-build found a potential issue with the 
following commit in linux-next today:

commit 1447ac26a96463a05ad9f5cfba7eef43d52913ef
Author: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Date:   Fri Jun 3 13:37:32 2022 +0800

     fsdax: output address in dax_iomap_pfn() and rename it


The analysis is as follows:


static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
                 size_t size, void **kaddr, pfn_t *pfnp)
{
         pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
         int id, rc;
         long length;

         id = dax_read_lock();
         length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
                                    DAX_ACCESS, kaddr, pfnp);
         if (length < 0) {
                 rc = length;
                 goto out;
         }
         if (!pfnp)
                 goto out_check_addr;

The above check jumps to out_check_addr, if kaddr is null then rc is not 
set and a garbage uninitialized value for rc is returned on the out path.


         rc = -EINVAL;
         if (PFN_PHYS(length) < size)
                 goto out;
         if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
                 goto out;
         /* For larger pages we need devmap */
         if (length > 1 && !pfn_t_devmap(*pfnp))
                 goto out;
         rc = 0;

out_check_addr:
         if (!kaddr)
                 goto out;
         if (!*kaddr)
                 rc = -EFAULT;
out:
         dax_read_unlock(id);
         return rc;
}


Colin

