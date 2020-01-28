Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2AD14BCE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 16:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgA1Pes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 10:34:48 -0500
Received: from mout.web.de ([212.227.15.4]:34821 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgA1Pes (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580225673;
        bh=kuan1BB3+eA9PIxqt53EP+BCiRzVeDYljJVoZy/dbB4=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=magfzL/LCejCnF1m+eOTktCEcrMZ0Sccs2LKTLKcshRS8xnFvkdDs3F6dMYGnxgAc
         UHfQJetNEDt5lX3PHJRL7SNv5Glo85HfDSKrGoFtP9EKjgUixgbdmfXlyghTA/cNOJ
         GfmzauQbHh4Z08Bj2Snu06/yiQgeO2H04wIlmz5s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.131.179]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZDQ4-1jHIcW3rR6-00KwnK; Tue, 28
 Jan 2020 16:34:33 +0100
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH v9 1/2] fs: New zonefs file system
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <23bf669d-b75f-ed94-478d-06bddd357919@web.de>
Date:   Tue, 28 Jan 2020 16:34:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AMoCxb91IWXlMPlqQqprS6vWSIadti+uj2r/Tk1/AQ8k/fKeo/W
 QOubQuhASzet5qZO4vapjEzmlAPd66/2mdV9tkLT0mRoap5QLRcg/8nViFipRtrbg4eszVB
 kZwKu2aCzWJSXmrfoB/YVnVWRQIEqfc84RnxXB2WUEzPvwHhsdAi67eilmdllQ3y7yK+Adk
 Rro8yhvkrtCIADf3m2U1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9mcCpnmjlE0=:RVG8+faCUcL+O1EKqG5NoQ
 AXaimUFMOCmLy+tB7qyj1igpwbmecyAcrInUnT8huaM2zLT4O+Op0DGqkiY7D7OYf4Klzrrw1
 w/SGWjhthcFAH9stj5r57pCIkXwV3fFimdcOZckZMu5Hl3w7ZuaYr/WXGyo5D+p28qKemJt5J
 DC2ASySNdtB1e9Ffq4HdOXXKarZQvPaHf+RmXqH/kNepGmMOOhIgV6aro4Ajs8jgLnc2+vslW
 M0YHY1yFCOa8+GDgq3CknoBQl1zyihFu1MsAE7L7PzYpBO02XeDCntdK1mAJkTbUSUc/m1Alk
 iQB+wJ5jC6+FAu5tBOcmYf/C4/msx2Tg3f/p36/LQ7i1P6q0UHKMc3srI9SXoBzNYdcS3n6up
 W3k2E93QMyejEZ4MdDmPXeeKBHTTHSfo3VLPZSHso0r1Vw9UT7AD6GjFXMYzhnjZNjGr6o5GF
 4y2xIY/Qvmj6H62cBLFdWp8jN5rReN2lu3GCTkrN2BDE+Risa3naBT4TYOvCeLfahSj3ol+Xm
 hoJQGG4t5Xrgtmh2QUWbD+7xHUgm/LkWK6FtGvfcvYCzbiutODCKntyet15alPl9Myg3RtUyR
 NbHNDsHYV0xeM7VmcfI5W2Xam0jsRCGBAFEp3Vttn+0b0aCXXKh/fhpht4MJmJErT/1OZl0BK
 rJikj2YEpMn/tg5L+TZp+lwBgWIPsxlEV4ZwU3z0Kqa67nAcYD/6/lM4ccZvbheOj5qmCMUwQ
 RUNu2JjnSDbaEtqB+KNvg3u2b8IkJ9Wr7CzhSd4WKCtlTW8s+1mdDimzqt48LIGJjDSafzjgI
 SaN4fIJ9YpSkAI6nZqXQqTiCmnJKD4OOMkOG3D/+p6q+2ZhKm6NqpxSkHQEcDofg0CKAUALGA
 E/qYVm9MKNZniPxBv//lWQbWJIPcGZBzGseCIlvhY7iBEap3xkZfEIE9zZQPuzaEdEkfcc5wJ
 P8R5V0+LeKOmnrMyhMGX2bcJS5PkRz7FzBLi5vSxKN7JNn9ioZNP9FFgeW9wRkN39Wjm1k1JJ
 BCeiKdGNxVWqmvKymH7jxkEEpE7Dms6pLO4fWcvNWO62+5upB2Iyu90Fl502aOSFBcQH3D9ST
 YKRkQhtAtClf8lGC2BIFZh6sAZWVycdXa7o0nWrmnLxGwWAuVcNgIOcnZ8Tl3qBrmDhsQmiFZ
 rdHv9LA63gX1H9p6fjVxvkaEaLSmabieRnizkSM60rFziYSCtUc+dm4noMz9JY7aMsQzhY86k
 0F8TfqQrV4vGvY7EF
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/zonefs/super.c
=E2=80=A6
> +out:
> +	kunmap(page);
> +out_free:
> +	__free_page(page);


Would you like to reconsider your name selection for such labels?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3Db0be0eff1a5ab77d588b76bd8b1c92d5=
d17b3f73#n460

Change possibility:

+unmap:
+	kunmap(page);
+free_page:
+	__free_page(page);


Regards,
Markus
