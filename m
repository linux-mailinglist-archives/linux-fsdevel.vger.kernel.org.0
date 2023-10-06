Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B5D7BB1B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 08:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjJFGsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 02:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjJFGsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:48:15 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA465E9
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 23:48:13 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231006064811epoutp01c3e3cd1d49d26a904649f0565f76b367~LceAUKLwZ0467204672epoutp01O
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 06:48:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231006064811epoutp01c3e3cd1d49d26a904649f0565f76b367~LceAUKLwZ0467204672epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696574891;
        bh=lHeSy0kMNy+eo4mTTXgkKEpVNPhh5hMDPwFY0Be+WGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oWVzNqEzuknJUJvxHAktQMEPFhm3Y2SE5QnHt27jKt/R7Vn6uNWla5oiaepTkgPy/
         Yk5LsaXhBeSKinDzhaE0xdToOLOKV3EAmvyF/82xBcZG0kNaoTK6Lm2xPYgqhEfJKW
         x+zSHnDNm2ritWd8U8Rd6O33RHJa6xlhiDdHzvCM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231006064811epcas5p123f75791c543d6b97820b54153253fcb~Lcd-nswfc1001310013epcas5p1q;
        Fri,  6 Oct 2023 06:48:11 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4S1zX94BsSz4x9QC; Fri,  6 Oct
        2023 06:48:09 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.0A.09949.9ADAF156; Fri,  6 Oct 2023 15:48:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231006064809epcas5p1823281fe74f5911896ac8c43eeb74eb8~Lcd9rEgRX1001210012epcas5p1e;
        Fri,  6 Oct 2023 06:48:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231006064809epsmtrp2c6237955e7b5d046a7599ec51e8428f0~Lcd9qOn9U1910019100epsmtrp2A;
        Fri,  6 Oct 2023 06:48:09 +0000 (GMT)
X-AuditID: b6c32a49-98bff700000026dd-4a-651fada9ed87
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.EB.08788.8ADAF156; Fri,  6 Oct 2023 15:48:08 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231006064807epsmtip2d0d2e9401542abee429f86e8e2703f3a~Lcd72AdT-1068810688epsmtip2S;
        Fri,  6 Oct 2023 06:48:06 +0000 (GMT)
Date:   Fri, 6 Oct 2023 12:12:03 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 03/15] block: Support data lifetime in the I/O
 priority bitfield
Message-ID: <20231006064203.GC3862@green245>
MIME-Version: 1.0
In-Reply-To: <20231005194129.1882245-4-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmlu7KtfKpBi8uSVu8/HmVzWL13X42
        i2kffjJbrHoQbvFgv73FnkWTmCxWrj7KZDHnbAOTxd5b2hZ79p5ksei+voPNYvnxf0wWD/48
        Znfg9bh8xdtj56y77B6Xz5Z6bFrVyeax+2YDm8fHp7dYPPq2rGL02Hy62uPzJjmP9gPdTAFc
        Udk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUB3KymU
        JeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOy
        M9rW3GcpOMdbcb39FmsD4w7uLkZODgkBE4m+xZ/Zuxi5OIQEdjNKTH+7kBnC+cQocb9lFROE
        841R4seMW0wwLV2de1ghEnsZJZYd6YDqf8Yocfz7IlaQKhYBFYln964AJTg42AQ0JS5MLgUJ
        iwhoSHx7sJwFpJ5ZYDWzROOtiywgNcICkRITdumC1PAK6Eicmb2bEcIWlDg58wkLiM0pYCUx
        68dnsLiogLLEgW3Hwa6TEDjBIbFryQlGiOtcJO5Ov8EGYQtLvDq+hR3ClpL4/G4vVDxZ4tLM
        c1DflEg83nMQyraXaD3VzwxyD7NAhsSUfaEgYWYBPone30+YQMISArwSHW1CENWKEvcmPWWF
        sMUlHs5YAmV7SLxcsw4RPgtO32ObwCg3C8k7sxA2zALbYCXR+aGJFSIsLbH8HweEqSmxfpf+
        AkbWVYySqQXFuempxaYFhnmp5fAoTs7P3cQITshanjsY7z74oHeIkYmD8RCjBAezkghveoNM
        qhBvSmJlVWpRfnxRaU5q8SFGU2DkTGSWEk3OB+aEvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OE
        BNITS1KzU1MLUotg+pg4OKUamCYczHW9w1x7YOMyudSeQxyv92uwHbj0QDzw/gG+g7pMTBvu
        Zt3dIWlXrnX41P+Lt69rJlg0SD07VNreMo9lrrl62dPCLfPu/Vr19buWsvP5M+uvmdy2Vjre
        c2/5Kn2Dx3vmbp/+fkbmzPknrlnIPLbgMb5VoZ2Q/mj+jcdemrfEDwmmrj3Kb/01nPFNpOoH
        detfFwTlmz6ncUzuWehRkP3grHbik8t1PGLur7cctW10Yw3kTgy0zCuZYB6d5e8gJVc7TeXa
        zsoqedXzKbUnEvZsPWsce/StoG31sbW1wo2FDPvquVq01HyfX38t2NG6ztpEsexg97KL/Gs3
        SWTGK7XwLH3xuF2kfCWDv2XQRyWW4oxEQy3mouJEAOR/Rw9RBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJXnfFWvlUgxX9phYvf15ls1h9t5/N
        YtqHn8wWqx6EWzzYb2+xZ9EkJouVq48yWcw528BksfeWtsWevSdZLLqv72CzWH78H5PFgz+P
        2R14PS5f8fbYOesuu8fls6Uem1Z1snnsvtnA5vHx6S0Wj74tqxg9Np+u9vi8Sc6j/UA3UwBX
        FJdNSmpOZllqkb5dAlfGsoUbmQsauCs+33rF2sDYwtnFyMkhIWAi0dW5h7WLkYtDSGA3o8SJ
        pw9YIBLiEs3XfrBD2MISK/89Z4coesIosffcRlaQBIuAisSze1eAEhwcbAKaEhcml4KERQQ0
        JL49WM4CUs8ssJ5Z4smDbiaQGmGBSIkJu3RBangFdCTOzN7NCDFzL6PE3DcbWCASghInZz4B
        s5kFzCTmbX7IDNLLLCAtsfwfB0iYU8BKYtaPz4wgtqiAssSBbceZJjAKzkLSPQtJ9yyE7gWM
        zKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKjTEtrB+OeVR/0DjEycTAeYpTgYFYS
        4U1vkEkV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvvtdW+KkEB6YklqdmpqQWoRTJaJg1Oqgalv
        91SDz3VeO8t8XdSDTxzNOsTwtGr/68m3avPyLVMqCxxy+j9tljgQOm9qYDN72J60X+z/myU1
        jpSWvnHvV9r7qvPvpIamJfJZewPNT8hUBYtceviZWV/t+cIFMYkZWxsL7/bON70Q//rqfSGF
        zHU/mQU+Le2dfGljc0O4UrtvWIvVaU0/a2tJnnQxTumj+2+mdcccCey8Z1oo7M6X3+i/dxv7
        PdXp1tXBr2wE42/kbp8Q9nm5i/sHqcVF09319+hpGrCufenbp9LuFmp4NOioyL2oLH3e/Y99
        tntzG6wo8l2zQ2BNXokq/4cn71ZJ2174dqAxJHCe3KSugJbuheHLarm+1Ylz5jflrP2qxFKc
        kWioxVxUnAgAMXia1yEDAAA=
X-CMS-MailID: 20231006064809epcas5p1823281fe74f5911896ac8c43eeb74eb8
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----IKYw8rt4xsi0beZH_Imxy96mvZbFJ64oQ.XZqp2ZTk-1zWLz=_4711e_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231005194219epcas5p2fb71011f490cdbc2510787d508d29732
References: <20231005194129.1882245-1-bvanassche@acm.org>
        <CGME20231005194219epcas5p2fb71011f490cdbc2510787d508d29732@epcas5p2.samsung.com>
        <20231005194129.1882245-4-bvanassche@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------IKYw8rt4xsi0beZH_Imxy96mvZbFJ64oQ.XZqp2ZTk-1zWLz=_4711e_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Thu, Oct 05, 2023 at 12:40:49PM -0700, Bart Van Assche wrote:
>The NVMe and SCSI standards define 64 different data lifetimes. Support
>storing this information in the I/O priority bitfield.
>
>The current allocation of the 16 bits in the I/O priority bitfield is as
>follows:
>* 15..13: I/O priority class
>* 12..6: unused
>* 5..3: I/O hint (CDL)
>* 2..0: I/O priority level
>
>This patch changes this into the following:
>* 15..13: I/O priority class
>* 12: unused
>* 11..6: data lifetime
>* 5..3: I/O hint (CDL)
>* 2..0: I/O priority level
>
>Cc: Damien Le Moal <dlemoal@kernel.org>
>Cc: Niklas Cassel <niklas.cassel@wdc.com>
>Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>---
> include/uapi/linux/ioprio.h | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
>index bee2bdb0eedb..efe9bc450872 100644
>--- a/include/uapi/linux/ioprio.h
>+++ b/include/uapi/linux/ioprio.h
>@@ -71,7 +71,7 @@ enum {
>  * class and level.
>  */
> #define IOPRIO_HINT_SHIFT		IOPRIO_LEVEL_NR_BITS
>-#define IOPRIO_HINT_NR_BITS		10
>+#define IOPRIO_HINT_NR_BITS		3

Should the comment[*] also be modified to reflect this change?

[*]
/*
 * The 10 bits between the priority class and the priority level are used to
 * optionally define I/O hints for any combination of I/O priority class and


------IKYw8rt4xsi0beZH_Imxy96mvZbFJ64oQ.XZqp2ZTk-1zWLz=_4711e_
Content-Type: text/plain; charset="utf-8"


------IKYw8rt4xsi0beZH_Imxy96mvZbFJ64oQ.XZqp2ZTk-1zWLz=_4711e_--
