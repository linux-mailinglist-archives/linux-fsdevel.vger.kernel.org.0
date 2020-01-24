Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6CF147833
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 06:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgAXFef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 00:34:35 -0500
Received: from sonic304-23.consmr.mail.gq1.yahoo.com ([98.137.68.204]:37913
        "EHLO sonic304-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729868AbgAXFee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 00:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1579844073; bh=UeJz9jyBNt5yayp7xj4f/SZWo0DpuycvuaFMYq1D8lg=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=NxNxPOFzSfORh0/j+CyjrCAXbIzvw6ZHJA0VT8plACOZ69yKZ55in66tkPbpWIcBeXRauEXemw1f9NZuEngyqU03g5dB2t0fRuOpKrpSqk8C7OW5sREI1tfvGJjw4vYKZ/lvWk3ek5sXuqAZt4K5kdJmwHm0MomdHvKzEawtNAehxb0CgxWxvNx+s99RX0sZNdPqqqSbCC6Aev27kzSxU6jkruWXIi0S0gL0xTj9CIwK1UdChRNGYcPS8deeuVlDZVq1SKvJ9xi1Y65+dhmbGqLOBiFGfdn31thYTepR1qhDojoNp+AVSFypKdEH2/fJUEGPrlDs7rirncqaTnWvYg==
X-YMail-OSG: jpBgorYVM1niDtoaJJkIHlAQwijPN.6fSmZoI4.D5pZpqmPkPgbrgdCc3bajoGE
 9NFLvAJZlQp9e_slnmrybNZnRd7.xfJeiO6p85yik1XdVrNwNPhSm7jC9gCYQpbQ1MkUkVhqXlP8
 CbEPhu4VEYevwxrsg6VN3Rpigk9xLiQ0ucRw.WZKNCtGQ_AkCTxq_fYq_ss8sbV.95yBQIXJ0RSE
 zRDQNhHjjg.aO7x1BBPbsgppivpLGEgOiP7lO9Z.lhCBjTtlCBAVap3b1O1SDS1bjkBV8phceVDM
 nFcv_4kWg4jLu8D.dxw_dzp_fyrhpnFP.AFhMPhf_hhugMfXrsiPdNzfoREF07wZDwdbuPOML59U
 Oo7RuXpvNk6UbxfDveVZFmJHvf1oaNZGMjrZcOaGq0E6mUW45Op3kBteRJ.Syn1W.FigWSPEMjbl
 OmdiDgOaJ2ExqCMAvX9L_99nm25IX76gES9xIONRNAu.vzQsrhtppRKnGUS9YiZ3IvX6CndPC2.F
 0wvZIz9aW8HHlg7FUPmiplPN91NmJrJ6aPO1noqJQSTV23HC38nDaMllXTr_GkK7TGnc94flHjou
 zwP0NLw8Sw_ajvTHDXIOSE4nKr08X0bJ8rqqwOl_HgHcte4Zoi1ZJqvUSiKA1UYOW27wzv8lcyrK
 e1WNg9KWHpUZHamY4taOgz8.8XNJ2F_i5RH4PapB4xFfr8cw9bAySh9Bkpy4VROqymI7I7JPY00q
 Iyy7E.wWJfM8ch.37t2vFxAqcqqm1PMlcXfeBQl9TFfNLq6cAKRZWsr8oNGp4HlJHApqOaFm1.Q4
 8RNzJwUqJ87Crb3sx0unDxhoHpV6AiXotap4dvQmv_f7aLd0GrG5hUccDlTdPCEklvQeP9nIEZqv
 OPy6RwATC6wnGkKQseChbiXzfsybZbyNpXc6tfzCjki99l23c44E9ukJdbDmWKNQ95ga73oghi.I
 97wQS8b3Vz9_x5Eh6yqw55CUvejzxvwFeM8DH4cskesjYGhgQQb2Vjr.AiPZeOu5d8umJZjTZG3g
 mcuTqSUCqRUF5C62h4Khc9AWYp57Mr59cTTFXwlCrSyYJFEp9l90dhncXdL4S.26.0SQ0vJvKhBZ
 X3BpqbjCVSdFOhNyzOnCp2_BrmCagUDAUATKCuedlydlI68tUQ_OkkkIHvOqoXSAO7meALGjHMsP
 OMISiC2VQSlwwKmGIDOFLJsDqTl6SLV1vDZ2r1nALsat6ul2TGkpmvM_q9AGMorgiS3LRghQWAvI
 z4EhmII8xNvwUT8cxPFrX06Yhfll.WNp7qiY6pMIb_ZkuZLaHhKochdff.I9l8U6QToEgzG0AEKD
 X1nwNxGlfh5jUxtNLWD267If67nf456b57TzIDkE1KOIbHMfgw4SLofRbwDWkPsZglTDkBaBnCWr
 1advyz4RlnpkNGQ9QV.pBaXmwhD6r72hh8fiCGsLBbA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Fri, 24 Jan 2020 05:34:33 +0000
Received: by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5154e0a93daa76c8f17f548eb900f9b7;
          Fri, 24 Jan 2020 05:34:30 +0000 (UTC)
Date:   Fri, 24 Jan 2020 13:34:23 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH] ext4: fix race conditions in ->d_compare() and ->d_hash()
Message-ID: <20200124053415.GC31271@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200124041234.159740-1-ebiggers@kernel.org>
 <20200124050423.GA31271@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200124051601.GB832@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124051601.GB832@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 09:16:01PM -0800, Eric Biggers wrote:

[]

> So we need READ_ONCE() to ensure that a consistent value is used.

By the way, my understanding is all pointer could be accessed
atomicly guaranteed by compiler. In my opinion, we generally
use READ_ONCE() on pointers for other uses (such as, avoid
accessing a variable twice due to compiler optimization and
it will break some logic potentially or need some data
dependency barrier...)

Thanks,
Gao Xiang


