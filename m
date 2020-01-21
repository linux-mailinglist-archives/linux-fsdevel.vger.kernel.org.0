Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10507143C12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 12:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgAULan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 06:30:43 -0500
Received: from mout.web.de ([212.227.15.3]:33937 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgAULan (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1579606227;
        bh=0Nzex0XT7/YzO25ENLqWPck0ARdy6b6i4z5TQe7obEI=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=nYTdfE3ZqTC4pYtDpNc2JiVC0blmA+8QK8r/nw4QpK41KwMuW6AlWbQCu9leiXilZ
         bWHDMJBahNoNWEX4pd2K029ZyXSitpdi7zMcxdR+DYRmNkJCTxom7TH1V6GTfrOT3t
         oO2+EYsszievvxuij+e2UqsrfBroSy0mjAw9XSdA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.33.93]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lh6fv-1jN8on49uZ-00oWSh; Tue, 21
 Jan 2020 12:30:27 +0100
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [PATCH v12 00/13] add the latest exfat driver
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Message-ID: <d8ff3ebe-1ad3-5a51-ad44-d45879237fb9@web.de>
Date:   Tue, 21 Jan 2020 12:30:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XT+TvrN5BDheR4YU3Iyj74D6IKlHagMkYC5cH6UG3eqN8RQmw2V
 mFkCawxtBiC5YA2oa+iG6zyl7SRvSNDDBuDN0HrU550l+y0nrTaj+p1JiyrCBxZ1SwL4asV
 td6tuMt8ITd55nzOvQcnp/9T1Yf8oKyNkkzeh0Do+p2pkNW2ADMMWhmt/LxfxTGbbBmAo1s
 pcX7aH7q3vI8clZ5V1w5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h+e2mu1AzIE=:caw0DSoU+Yv2U1nCERf8AX
 LVy/WeKRj7rBbMBcKUGJxuQivmb6UaF0R+AOMyxh07MDPACw06NHXskSMUcTam9VJLH2bHKzT
 1p/DDAavXFywt4Fw93z5QtRH8dUXjzvbI8a3j7EaACyQzDCP8gpvAvYPv+aX7M1cTFVW+vUEH
 CMnS3LwX3IS5hopl2NLhBsXcUgdIxZbIYryBXvAeTDZFmL4G66VPdS4JS4b0SKTrUVFLQFbhq
 m33KIGj+4tD0fXhhLCmSJNqBKVZ7r2P6SVT40GjoOxSyuvzAnrwSs2XkmyN7/VcKrcAQHv6dg
 dskS4o4CviBqkEy6c0grJcQHHxbIk6qQwST7lpeVcItjLRIw7dfEcS7WNI0xLnZQTzIofHRRT
 w1ds94+inx93JCwyaUc6wQvNoOcuFMS9E1In3oUbHYYF/6WB/fD6/b3T+bNzRk0bK3cA9Ad4G
 77fSNDIvXw8LIev1Hn8jD3RJ3X5Q8id+isW/vYnSFpuMa9RKcr93vj5OsxDUYNs8lUisFaxa0
 s3TXvRiz7oMQOk6rhntGAYPowXdP1AlB6epRg+FgIjmZ2xZxaSDVquMgosRrSXm8vhQ07B+RE
 lJHsxkUYxgMH7vLBDeosyjfyiFAGRrB2MHYXW6FJwV0wf9ngpeS44xuHIn9IUsV7FUKidS0xY
 IjsxV1akrWjNj63X+4AZZZxpvu7hEFJCIovOQt0xC1g47MpBgj4qf8PNPumAavyqf+D4hLcYT
 BPyZGaRwoQHonrvPgedNQ+BVo6F3/sMc1iXiGo6ucLSmbDem2+LwvXzGYWyBpHNje4R7sQsoH
 lS06HfgojxruZjEbVaqeafk3sSKClcuIq18hX0EKlbHDYrd12tKcUj8C4vYjT80WFapRw9nJx
 Z/CfhG6pl367b/xww2D0q8VDvQDhleX9edj4JCG4IlDe0bnea4uRVgxhuI50kFxl0oGFJbs/g
 ImlIJ1kVz+PAtvBoV3LTaDCPgOe/XJD65dQa6c2+f/WSw3V2i9PVP9TJvMwZaa5Ey+POOp9ZK
 pqc4S95Uk+1ohQ61VefejuMtKMTPYF0NeHS7HmjCYsm60J2FYjnKLVoTIKwOZJTYMPZm5+SNX
 emy9l2qAg4Yj2NK70MWI35ymYLq9e6amQMHeE7yVMhgK1qQh9a4pToCaWuIMrMl5RVIgPqGpS
 9jK7kzvORu9KF1OqysqxzLwyw1t+CXSGKLxgUNiPXp02weiqQFAorzIA2ldrjuqnoFbx9q4lp
 zjw7EqX29hN3j7TXrPJ5T7rFbXX/fgMpiOswLNX2bb5Gwhfo6+xdbiWrY9bo=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> We plan to treat this version as the future upstream for the code base
> once merged, and all new features and bug fixes will go upstream first.
>
> v12:

Will another issue tracker become relevant for the discussed software evol=
ution?


=E2=80=A6
> v10:
=E2=80=A6
> =E2=80=A6 utf16 surrogage pair =E2=80=A6

Do you really insist to preserve a typo in such an information?

Regards,
Markus
